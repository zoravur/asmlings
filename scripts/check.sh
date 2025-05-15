#!/bin/bash

src=$1
expected=$2

tmp_actual=$(mktemp)
tmp_expected=$(mktemp)

gcc -O2 -S -masm=intel "$src" -o - |
  python3 scripts/normalize_asm.py > "$tmp_actual"

python3 scripts/normalize_asm.py < "$expected" > "$tmp_expected"

if git diff --no-index "$tmp_actual" "$tmp_expected"; then
  echo "✅ $src"
else
  echo "❌ $src"
#   echo "--- expected:"
#   cat "$tmp_expected"
#   echo "--- actual:"
#   cat "$tmp_actual"
fi

rm "$tmp_actual" "$tmp_expected"
