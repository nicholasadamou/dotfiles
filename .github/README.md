# Nick's dotfiles 

Nick's sensible defaults based on [`set-me-up-blueprint`](https://github.com/dotbrains/set-me-up-blueprint).

## What's inside

1.  A `rcm` tag called [nicholas](/dotfiles/tag-nicholas) and an adapted `rcrc` file.
2.  [Installer](/dotfiles/modules/install.sh) that is required to download `set-me-up` on top of my blueprint.

## How to use

[![xkcd: Automation](http://imgs.xkcd.com/comics/automation.png)](http://xkcd.com/1319/)

1.  [Read the docs](https://github.com/dotbrains/set-me-up-docs#set-me-up).
2.  Use the [installer](/dotfiles/modules/install.sh) to obtain `set-me-up` and Nick's blueprint.

    (⚠️ **DO NOT** run the `install` snippet if you don't fully
understand [what it does](/dotfiles/modules/install.sh). Seriously, **DON'T**!)

        bash <(curl -s -L https://raw.githubusercontent.com/nicholasadamou/dotfiles/main/dotfiles/modules/install.sh)

3. Use the `smu` script (which you will find inside the `smu` home directory) to run the base module.

        bash ~/set-me-up/set-me-up-installer/smu --base

    ⚠️ Please note that after running the base module, moving the source folder is not recommended due to the usage of symlinks.

## License

The code is available under the [MIT license](LICENSE).
