import sys
import re

def normalize_brackets(line):
    def replacer(match):
        contents = match.group(1)
        # remove all internal spaces
        contents = re.sub(r'\s+', '', contents)
        return f'[{contents}]'
    return re.sub(r'\[(.*?)\]', replacer, line)

for line in sys.stdin:
    line = line.strip()
    if not line or line.startswith('.') or ':' in line:
        continue
    line = normalize_brackets(line)
    line = re.sub(r',\s*', ',', line)          # remove space after commas
    line = re.sub(r'\s+', ' ', line)           # collapse all other spaces
    print(line)
