# bash

This repository contains my sensible defaults for bash.

## Usage

The contents of this repository should be placed in your `$HOME/.config`. 

```bash
git clone https://github.com/dotbrains/bash.git $HOME/.config/bash
```

In your `$HOME` directory you would want a `.bashrc` that contains:

```bash
#!/bin/bash

[ -n "$PS1" ] \
    && . ~/.config/bash/bash_profile \
    && . ~/.bash.local # For local settings that should not be under version control.
```

## License

The code is available under the [MIT license](LICENSE).