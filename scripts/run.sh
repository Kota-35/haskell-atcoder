#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: scripts/run.sh <problem_dir> [input_file]" >&2
  echo "Example: scripts/run.sh contests/abc350/a contests/abc350/a/tests/sample1.in" >&2
  exit 2
fi

problem_dir="$1"
input_file="${2:-}"

main_file="$problem_dir/Main.hs"

if [[ ! -f "$main_file" ]]; then
  echo "Main.hs not found: $main_file" >&2
  exit 2
fi

mkdir -p .atcoder-bin

exe=".atcoder-bin/run"

if ! cabal exec -- ghc -O2 -outputdir .atcoder-bin -o "$exe" "$main_file" >/dev/null; then
  echo "Compilation failed." >&2
  exit 1
fi

echo "Compiled: $main_file"

if [[ -n "$input_file" ]]; then
  "$exe" < "$input_file"
else
  "$exe"
fi
