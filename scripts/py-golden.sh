#!/bin/sh
# Dev only: regenerate tests/python/golden with the reference rythonc 1.1.0, which parses
# with CPython (needs libpython). CPython is never used by builds, tests or at runtime.
#
# rythonc is taken from the cargo registry source if it is already there, otherwise its
# .crate is downloaded from crates.io and checked against the index checksum. It is built
# into $CARGO_TARGET_DIR (default: target/) under rythonc-ref; scratch files go in a
# temporary directory that is removed on exit.
set -eu
cd "$(dirname "$0")/.."
root=$(pwd)
version=1.1.0
corpus=$root/tests/python
target=${CARGO_TARGET_DIR:-$root/target}/rythonc-ref
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT INT TERM

src=$(ls -d "${CARGO_HOME:-$HOME/.cargo}"/registry/src/*/rythonc-$version 2>/dev/null | head -1 || true)
if [ -z "$src" ]; then
  want=$(curl -fsS https://index.crates.io/ry/th/rythonc |
    sed -n "s/.*\"vers\":\"$version\".*\"cksum\":\"\([0-9a-f]*\)\".*/\1/p")
  curl -fsSL -o "$work/rythonc.crate" "https://static.crates.io/crates/rythonc/rythonc-$version.crate"
  echo "$want  $work/rythonc.crate" | sha256sum -c --quiet -
  tar -xzf "$work/rythonc.crate" -C "$work"
  src=$work/rythonc-$version
fi
cargo build -q --release --locked --manifest-path "$src/Cargo.toml" --target-dir "$target"
ry=$target/release/rythonc

mkdir -p "$work/run"
rm -f "$corpus"/golden/*
for f in "$corpus"/rythonc/*.py "$corpus"/pytests/*.py; do
  name=$(basename "$(dirname "$f")")_$(basename "$f" .py)
  # rythonc derives the module name from the path: always compile as user.py
  cp "$f" "$work/run/user.py"
  if (cd "$work/run" && "$ry" user.py -o out.rs) > "$work/log" 2>&1; then
    cp "$work/run/out.rs" "$corpus/golden/$name.rs"
  else
    : > "$corpus/golden/$name.err"
  fi
done
ls "$corpus"/golden | wc -l
