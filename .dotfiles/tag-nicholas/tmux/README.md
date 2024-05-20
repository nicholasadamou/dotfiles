# tmux

This is my personal configuration for [tmux](https://github.com/tmux/tmux/wiki). 

## Uses

I utilize [`tpm`](https://github.com/tmux-plugins/tpm) for plugin management. 

## Getting Started

Install _tmux_. I prefer to use `brew`:

```bash
brew install tmux
```

Clone this repository to `~/.tmux`:

```bash
git clone --recursive https://github.com/dotbrains/tmux ~/.tmux
```

Next create `~/.tmux.conf` with the contents:

```text
source-file ~/.tmux/tmux.conf
```

Then, open `tmux` and press `ctrl-space` + `I` to install plugins.