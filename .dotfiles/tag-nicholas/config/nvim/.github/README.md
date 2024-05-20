# nvim

This is my personal configuration for [neovim](https://neovim.io/). 

## Why did I build this?

I built this in an effort to construct my [_personal development environment_](https://www.youtube.com/watch?v=IK_-C0GXfjo). Essentially, it is a completely personalized space that is completely tailored to me rather than using a more bloated environment such as VS Code or JetBrains IDEs.

## Getting Started

Install _neovim_. I prefer to use `brew`:

```bash
brew install nvim
```

Install some dependencies for _neovim_.

```bash
brew install lua-language-server ripgrep fd code-minimap deno
```

Clone this repository to `~/.config/nvim`:

```bash
git clone https://github.com/dotbrains/nvim ~/.config/nvim
```

Then, open `neovim` and wait for the plugins to install.
