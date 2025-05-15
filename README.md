# 🦾 asmlings — learn to read the machine

> 🚧 This project is in active development. Expect rough edges.

**asmlings** is a compiler vision dojo.  
You write C. You predict its assembly.  
You get better.

---

## Why?

Linus said:

> _"When I write C, I know what the assembly will look like."_

This project helps you get there.

By drilling small, focused C functions and writing what you _think_ the compiler will emit, you build deep, accurate compiler intuition. In theory, anyway.

---

## How It Works

Each exercise consists of:

- `XX_name.c` — the C input (you may read but not modify)
- `XX_name.expect.asm` — your prediction of the compiler's output, written by hand
- The check system compares your `.expect.asm` against the real output from `gcc -O2 -masm=intel`

---

## Getting Started

### 1. Clone and enter the repo

```bash
git clone https://github.com/yourname/asmlings.git
cd asmlings
```

### 2. Install dependencies

You'll need:

- `gcc`
- `make`
- `bash`
- `python3`
- `git` (for diffing)
- optional: `git diff`, `less`, `colordiff`, `delta`

### 3. Add the wrapper to your path

```bash
ln -s "$PWD/asmlings" ~/bin/asmlings # or some other directory on your path
chmod +x asmlings
```

---

## Commands

```bash
asmlings list         # list available exercises
asmlings check N      # test your .expect.asm for exercise N
asmlings diff N       # see the diff (reveals answer)
asmlings --help       # show help
```

---

## Example

`lessons/level0/01_add.c`

```c
int add(int x) {
  return x + 1;
}
```

`lessons/level0/01_add.expect.asm` — you write:

```asm
lea eax,[rdi+1]
ret
```

```bash
asmlings check 1   # ✅ or ❌
asmlings diff 1    # show real vs your .expect.asm
```

---

## License

MIT.
Use this to grow. Fork and train others.

## Contributing

PRs welcome.
