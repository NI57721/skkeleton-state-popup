# skkeleton-state-popup
([Here is the Japanese document](README-ja.md))

Displays the state of [skkeleton](https://github.com/vim-skk/skkeleton) in a
popup window for Vim/Neovim.  
![screenshot](https://raw.githubusercontent.com/NI57721/skkeleton-state-popup/assets/screenshot.gif)

## Installation
You can use your preferred plugin manager.

## Prerequisite
[denops.vim](https://github.com/vim-denops/denops.vim)  
[skkeleton](https://github.com/vim-skk/skkeleton)

## Usage

Register your configuration by executing `skkeleton_state_popup#config()`, and
then `skkeleton_state_popup#enable()` to activate it. You can set the strings that
displays in a popup window and the option of the window with
`skkeleton_state_popup#config`. You can stop the popup by executing
`skkeleton_state_popup#disable()` whenever you like.

In Vim, you can specify the popup window options, which is used as an argument
when executing `popup_create()`.

In Neovim, you can specify the window options, which is used as an argument when
executing `nvim_open_win()`. Note that the option of the function requires some
keys. You need to specify them. The keys `width` and `height` are calculated and
specified by the plugin, so you do not need to do about them.

Here are examples of the configurations. For more information, read the
[doc](doc/skkeleton_state_popup.txt). # WIP
### Vim
```vim
call skkeleton_state_popup#config(#{
  \   labels: {
  \     'input': #{hira: 'あ', kata: 'ア', hankata: 'ｶﾅ', zenkaku: 'Ａ'},
  \     'input:okurinasi': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽', abbrev: 'ab'},
  \     'input:okuriari': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽'},
  \     'henkan': #{hira: '▼▼', kata: '▼▼', hankata: '▼▼', abbrev: 'ab'},
  \     'latin': '_A',
  \   },
  \   opts: #{pos: 'botleft', line: 'cursor+1', col: 'cursor', highlight: 'WildMenu'},
  \ })
call skkeleton_state_popup#run()
```

### Neovim
```vim
call skkeleton_state_popup#config(#{
  \   labels: {
  \     'input': #{hira: "あ", kata: 'ア', hankata: 'ｶﾅ', zenkaku: 'Ａ'},
  \     'input:okurinasi': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽', abbrev: 'ab'},
  \     'input:okuriari': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽'},
  \     'henkan': #{hira: '▼▼', kata: '▼▼', hankata: '▼▼', abbrev: 'ab'},
  \     'latin': '_A',
  \   },
  \   opts: #{relative: 'cursor', col: 0, row: 1, anchor: 'NW', style: 'minimal'},
  \ })
call skkeleton_state_popup#run()
```

## Licence
MIT Licence

