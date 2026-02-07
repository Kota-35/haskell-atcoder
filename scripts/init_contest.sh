#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: scripts/init_contest.sh <contest> [problem...]" >&2
  echo "Example: scripts/init_contest.sh abc350 a b c" >&2
  echo "If no problems are given, defaults to: a b c d e f" >&2
  exit 2
fi

contest="$1"
shift || true

if [[ $# -eq 0 ]]; then
  problems=(a b c d e f)
else
  problems=("$@")
fi

base_dir="contests/$contest"

for p in "${problems[@]}"; do
  dir="$base_dir/$p"
  mkdir -p "$dir/tests"

  main_file="$dir/Main.hs"
  if [[ ! -f "$main_file" ]]; then
    cat > "$main_file" <<'HS'
module Main where

main :: IO ()
main = do
    -- Example:
    -- [n, k] <- map read . words <$> getLine :: IO [Int]
    -- ps <- map read . words <$> getLine :: IO [Int]
    pure ()
HS
  fi

done

echo "Initialized: $base_dir (${problems[*]})"
