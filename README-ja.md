# skkeleton-state-popup
([英語のドキュメントはこちら](README.md))

Skkeleton の状態をポップアップで表示するためのプラグインです。Vim/Neovim 両方に対応しています。  
![screenshot](https://raw.githubusercontent.com/NI57721/skkeleton-state-popup/assets/screenshot.gif)

## インストール
好みのプラグイン・マネージャーを使用してください。

## 依存プラグイン
[denops.vim](https://github.com/vim-denops/denops.vim)  
[skkeleton](https://github.com/vim-skk/skkeleton)

## 使用法

`skkeleton_state_popup#config()`で設定を登録して、`skkeleton_state_popup#enable()`で設定を適用させます。`skkeleton_state_popup#config()`では、ポップアップに表示する文字列と、ポップアップ・ウィンドウのオプションを設定することができます。ポップアップの表示を止めるには`skkeleton_state_popup#disable()`を実行します。

Vim では、`popup_create()`に渡すオプションを指定できます。

Neovim では、`nvim_open_win()`に渡すオプションを指定できます。この関数のオプションには必須の項目があるので適宜設定してください。なお、`width`と`height`に関してはプラグインが内部で値を適用させるので設定する必要はありません。

以下に設定例を用意しました。詳しくは[ドキュメント](doc/skkeleton_state_popup.txt)もご覧ください。 # ドキュメントは準備中
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
call skkeleton_state_popup#enable()
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
call skkeleton_state_popup#enable()
```

## ライセンス
MIT Licence

