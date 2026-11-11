# Python translation corpus

`rythonc/*.py` are the test inputs of Rython's `rythonc` 1.1.0 (Apache-2.0, same license
as `src/python_ast`); `pytests/*.py` are python-ast 1.1.0's.

`golden/*.rs` is what the reference `rythonc` 1.1.0, which parses with CPython, produces for
each input (`golden/*.err` when it rejects the input). The pure-Rust path
(`src/pyconv.rs`) must produce the same Rust token stream; see the
`corpus_matches_cpython_rythonc` test.

CPython is used only to make the goldens, never in builds or at runtime:

    scripts/py-golden.sh   # from the repository root: builds the reference rythonc (into
                           # $CARGO_TARGET_DIR or target/) and rewrites golden/

The script is in the git repository, not in the published crate. Check the result with
`git diff tests/python/golden` (no diff means the goldens are unchanged) and `cargo test`.
