#!/usr/bin/env bash
set -euo pipefail

cabal exec -- fourmolu -i contests
