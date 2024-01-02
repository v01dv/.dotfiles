## Dependencies

Ripgrep

```
paru -S ripgrep fd
```

For LUA formatting:
```
paru -S stylua
```
For Python formatting:
```
paru -S flake8 black
```

For shell linter and formatting
```
paru -S shellcheck-bin shfmt

```

TODO:
1. Setup codelens for JS
2. Create keybandings for https://github.com/rmagatti/auto-session plugin:
:SaveSession " saves or creates a session in the currently set `auto_session_root_dir`.
:SaveSession ~/my/custom/path " saves or creates a session in the specified directory path.
:RestoreSession " restores a previously saved session based on the `cwd`.
:RestoreSession ~/my/custom/path " restores a previously saved session based on the provided path.
:RestoreSessionFromFile ~/session/path " restores any currently saved session
:DeleteSession " deletes a session in the currently set `auto_session_root_dir`.
:DeleteSession ~/my/custom/path " deleetes a session based on the provided path.
:Autosession search
:Autosession delete


### For nvim-spectre
You need install rg and sed
- BurntSushi/ripgrep <https://github.com/BurntSushi/ripgrep> (finder)
- devicons <https://github.com/kyazdani42/nvim-web-devicons> (icons)
- sed <https://www.gnu.org/software/sed/> (replace tool)
