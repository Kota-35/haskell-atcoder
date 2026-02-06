#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: scripts/test.sh <problem_dir>" >&2
  echo "Example: scripts/test.sh contests/abc350/a" >&2
  exit 2
fi

problem_dir="$1"
main_file="$problem_dir/Main.hs"
test_dir="$problem_dir/tests"

if [[ ! -f "$main_file" ]]; then
  echo "Main.hs not found: $main_file" >&2
  exit 2
fi

if [[ ! -d "$test_dir" ]]; then
  echo "tests directory not found: $test_dir" >&2
  exit 2
fi

mkdir -p .atcoder-bin

exe=".atcoder-bin/run"

if ! ghc -O2 -outputdir .atcoder-bin -o "$exe" "$main_file" >/dev/null; then
  echo "Compilation failed." >&2
  exit 1
fi

echo "Compiled: $main_file"

shopt -s nullglob
inputs=("$test_dir"/*.in)

if [[ ${#inputs[@]} -eq 0 ]]; then
  echo "No .in files found in $test_dir" >&2
  exit 2
fi

fail=0
for infile in "${inputs[@]}"; do
  base="${infile%.in}"
  expected="$base.out"
  name="$(basename "$base")"

  if [[ ! -f "$expected" ]]; then
    echo "[SKIP] $name (missing .out)" >&2
    continue
  fi

  output=".atcoder-bin/$name.out"
  "$exe" < "$infile" > "$output"

  if diff -u "$expected" "$output" >/dev/null; then
    echo "[OK]   $name"
  else
    echo "[FAIL] $name"
    diff -u "$expected" "$output" || true
    fail=1
  fi
 done

exit $fail
