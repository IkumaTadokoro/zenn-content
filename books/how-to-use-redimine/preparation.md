---
title: "事前準備"
---

# 事前準備

このChapterではRubyMineを習得するための下準備として、

- [プラグインについて](#プラグインとは)：以下のプラグインを導入するために、プラグインについて学びます
- [学習を支えるプラグイン](#学習を支えるプラグイン)：学習を支える3つのプラグインを紹介します
- [RubyMineのウィンドウ](#ウィンドウ)：RubyMineを開いた時に見える各ウィンドウの名称を整理します

について学んでいきます。

## プラグイン

RubyMineの機能を拡張してくれるツールのことです。
RubyMineはデフォルトでもかなり高機能で、1年に数回アップデートが実施されていますが、プラグインを利用することで、より細かい部分の生産性を向上させることができます。

## プラグインの導入方法

プラグインの導入はRubyMine上のメニューから行います。
ここでは次にご紹介する「Japanese LanguagePack/日本語化パック」を例にして、プラグインの導入方法を説明します。

![](/images/preparation/how-to-install-plugin.gif)

1. `⌘` + `,`を押して、Preferencesを開きます。
2. 左側のメニューから「Plugins」を選択します。
3. 画面右側「Marketplace」を選択します。
4. 「Type / to see options」と記載されている検索窓に「japan」と入力します。
5. 表示された「Japanese LanguagePack/日本語化パック」を「INSTALL」します（GIFではインストール済のため、表示が異なります）

ここまでで、指定したプラグインを自分のRubyMineで使用することができるようになりました。
ただし、インストールしただけではプラグインは無効状態ですので、これを有効化します。

![](/images/preparation/how-to-activate_plugin.gif)

1. Preferences > Pluginsの中で、今度は「Installed」を選択します。
2. 「Type / to see options」と記載されている検索窓に「japan」と入力します。
3. 表示された「Japanese LanguagePack/日本語化パック」にチェックをし、「APPLY」をクリックします。
4. 「OK」を選択すると、RubyMineを再起動して良いか聞かれるので「RESTART」を選択します
5. 再起動後画面を確認すると、プラグインが適用され、メニューが日本語になっています。

![](/images/preparation/rubymine-210814-14:21:12.png)

以上がプラグインの導入方法になります。他のプラグインについても導入手順は同じです。
なお、有効化したプラグインをやっぱり使用したくないと思った際は、「Installed」にあるプラグインのチェックを外すことで無効化できます。

プラグイン自体を削除する場合は、各プラグインの設定（歯車）アイコンから「Uninstall」を選択してください。

![](/images/preparation/rubymine-210814-15:08:43.png)

## 学習を支えるプラグイン

### Japanese LanguagePack/日本語化パック

https://plugins.jetbrains.com/plugin/13964-japanese-language-pack------

RubyMineのすべてのメニューを日本語化するプラグイン

:::details 概要
その名の通り、RubyMineを日本語化してくれるパッケージです。
「RubyMineのメニューが英語でわからん！」という方にはぜひおすすめです。

各種操作方法を記載している[RubyMineの公式Wiki| RubyMine](https://pleiades.io/help/ruby/installation-guide.html)についても日本語化されているため、「日本語化をしたことで、公式情報が追いにくくなる」という心配もありません。

個人的にはエディタの中でプログラミングに一般的に利用される英語を学ぶことができるという点から、英語設定のまま使用していますが、 そこは個人の好みで選んで良いでしょう。

もちろんプラグインなので、ON/OFFの切り替えはいつでも可能です。
:::

### Key Promoter X

https://plugins.jetbrains.com/plugin/9792-key-promoter-x

ショートカットキーがあるメニューを、ショートカットキーなしで使用した場合にポップアップを表示するプラグイン

:::details ショートカットのチェックと記録

RubyMineのメニューを使用した際に、もしショートカットがあるメニューであれば、画面右下にポップアップが表示されます。

例えば、Project、つまりファイル一覧は`⌘` + `1`で開くことができるのですが、これをマウスクリックで開くと、ポップアップが表示されます。
「おまえさんは180回もこのショートカットをミスってるね」というメッセージ付きです笑

![](/images/preparation/rubymine-210814-14:47:03.png)

ショートカットをミスした回数の一覧と使用した回数の一覧は画面右側にある「Key PromoterX」のメニューから確認することができます。
先程の`⌘` + `1`は180回ミスして、103回ショートカットで開いていることがわかります。
![](/images/preparation/rubymine-210814-14:56:37.png)

もし「Key PromoterX」が表示されていない場合は、`Shift` + `Shift`でSearchEveryWhere（後述）を呼び出し、「KeyPormoterX」と検索してください。
:::

:::details ショートカットキーの登録促進
またショートカットが設定されていないプラグインの場合は、「ショートカットを作りませんか？」という提示が出てきます。

例えば下記は、ディスクの内容とRubyMine上で表示されている内容を同期する「Reload from Disk」というメニューを使用したケースです。
こちらにはデフォルトショートカットが割り当てられていないため、ショートカットキー登録のお誘いが出ています。

![](/images/preparation/rubymine-210814-14:50:08.png)

「Reload from Disk（使用したメニューの名前）」を選択することで、ショートカットキー登録のメニューに遷移することができます。

![](/images/preparation/rubymine-210814-15:04:14.png)

※ショートカットキーの登録方法については割愛します。
詳細は[キーボードショートカットを設定する \| RubyMine](https://pleiades.io/help/ruby/configuring-keyboard-and-mouse-shortcuts.html)を参考にしてください。
:::

:::details ポップアップを停止する

ポップアップがうざったく感じたら、ポップアップに表示されている「Disable alert for this shortcut」を選択することで、通知をオフにすることができます。

また画面左側の「Key Promoter X」にある「Snooze Notifications」からも通知を停止することが可能です。

![](/images/preparation/rubymine-210814-15:10:21.png)
:::

### IDE Features Trainer

https://plugins.jetbrains.com/plugin/8554-ide-features-trainer

初期設定でインストールされている、IDEの機能を学習するためのプラグイン

:::details 概要
![](/images/preparation/rubymine-210822-12:34:27.png)

メニューバーのHelp > Learn IDE Featuresを選択することで、チュートリアル画面が開きます。
全編英語にはなりますが、RubyMineの基本的な操作を、サンプルを交えながら実践できるため、英語が苦手でなければ試して見るのもいいと思います。
:::

## ウィンドウ

RubyMineを開くと、画面内にいろいろなウィンドウが表示されています。
以降のChapterでは、RubyMineの公式呼称に則って説明を進めます。

![](/images/preparation/rubymine-210814-16:21:44.png)

| 番号 | 名称                         |
| ---- | ---------------------------- |
| 1    | ナビゲーションバー           |
| 2    | プロジェクトツールウィンドウ |
| 3    | エディター                   |
| 4    | コンテキストメニュー         |
| 5    | 実行ツールウィンドウ         |
| 6    | ステータスバー               |

なお本書での頻出用語は「コンテキストメニュー」ですが、これは右クリックした際に表示されるメニューのことです。
