# Dotfiles

Portable dotfiles using [dotbot][]. Just needs bash.

Colors assume that your terminal is using [dracula][] but should be readable
on most anything.

The installer will *erase* your existing files. It can also take several
minutes to run on a slow machine, as we build a number of utilities from
source. Just run: `./install` to get started. Alternatively you can use these
dotfiles the good ol' fashion copy-and-paste way. If apps are missing, all
dotfiles should gracefully ignore them.

## Utilities

The bootstrap will set you up with a few utilities:

- rust, rustup, and cargo.
- *exa*, an *ls* alternative.
- *fd*, a *find* alternative.
- *hexyl*, a clean hex viewer.
- *bat*, a context-aware *cat*.

The color schemes used by all these tools should be aesthetically pleasing with
the [dracula][] terminal color scheme.

## Extra integrations

- If *silversearcher* is present:
    - Will be used by Vim's ctrl-p plugin for _much_ faster search.
    - Will use the ag.vim plugin for integration (`\ag`)

- If *Dash.app* is present:
    - Will enable `<leader>-d` in Vim to search for the current word in dash.

- If *python-language-server* is present:
    - Will enable Python completion in Vim.
    - Install flake8 to also enable linting.

## Why is this public?

Honestly? Public repos get unlimited Github Action runtime.

[dotbot]: https://github.com/anishathalye/dotbot
[dracula]: https://github.com/dracula/dracula-theme
