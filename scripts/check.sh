#!/bin/bash

src=$1
expected=$2
mode=$3  # --quiet or --diff

tmp_actual=$(mktemp)
tmp_expected=$(mktemp)

gcc -O2 -S -masm=intel "$src" -o - |
  python3 scripts/normalize_asm.py > "$tmp_actual"

python3 scripts/normalize_asm.py < "$expected" > "$tmp_expected"

if diff -q "$tmp_actual" "$tmp_expected" >/dev/null; then
  echo "✅ $src"
else
  echo "❌ $src"
  if [ "$mode" = "--diff" ]; then
    git diff --no-index "$tmp_expected" "$tmp_actual"
  else
    echo "(run \`make diff N\` to view the expected vs actual output)"
  fi
fi

rm "$tmp_actual" "$tmp_expected"
