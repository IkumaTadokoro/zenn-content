---
title: "事前準備"
---

RubyMineの使い方を覚える前の事前準備として、必要に応じてプラグインを導入しましょう。

## プラグインとは

RubyMineの機能を拡張してくれるツールのことです。
RubyMineはデフォルトでもかなり高機能で、1年に数回のマイナーアップデートが実施されていますが、プラグインを利用することで、より細かい部分の生産性を向上させることができます。

## プラグインの導入方法

プラグインの導入はRubyMine上のメニューから行います。
ここでは次にご紹介する「Japanese LanguagePack/日本語化パック」を例にして、プラグインの導入方法を説明します。

![](/images/preparation/how-to-install-plugin.gif)

1. `⌘` + `,`を押して、Preferencesを開きます。
2. 左側のメニューから「Plugins」を選択します。
3. 画面右側「MarketPlace」を選択します。
4. 「Type / to see options」と記載されている検索窓に「japa」と入力します。
5. 表示された「Japanese LanguagePack/日本語化パック」を「INSTALL」します（GIFではインストール済のため、表示が異なります）

ここまでで、指定したプラグインを自分のRubyMineで使用することができるようになりました。
ただし、インストールしただけではプラグインは無効状態ですので、これを有効化します。

![](/images/preparation/how-to-activate_plugin.gif)

1. Preferences > Pluginsの中で、今度は「Installed」を選択します。
2. 「Type / to see options」と記載されている検索窓に「japa」と入力します。
3. 表示された「Japanese LanguagePack/日本語化パック」にチェックをし、「APPLY」をクリックします。
4. 「OK」を選択すると、RubyMineを再起動して良いか聞かれるので「RESTART」を選択します（起動中のアプリケーションがあった場合、終了しても良いか聞かれますので、あらかじめ終了しておくか、「TERMINATE」を選択して強制終了してください）
5. 再起動後画面を確認すると、プラグインが適用され、メニューが日本語になっています。

![](/images/preparation/rubymine-210814-14:21:12.png)

以上がプラグインの導入方法になります。他のプラグインについても導入手順は同じです。
なお、有効化したプラグインをやっぱり使用したくないと思った際は、「Installed」にあるプラグインのチェックを外すことで無効化できます。

プラグイン自体を削除する場合は、各プラグインの設定（歯車）アイコンから「Uninstall」を選択してください。

![](/images/preparation/rubymine-210814-15:08:43.png)

## Japanese LanguagePack/日本語化パック

![](/images/preparation/rubymine-210814-14:43:15.png)

- 概要：RubyMineのすべてのメニューを日本語化する
- プラグイン公式：[Japanese Language Pack / 日本語言語パック \- IntelliJ IDEs Plugin \| JetBrains Marketplace](https://plugins.jetbrains.com/plugin/13964-japanese-language-pack------)

その名の通り、RubyMineを日本語化してくれるパッケージです。
「RubyMineのメニューが英語でわからん！」という方にはぜひおすすめです。

各種操作方法を記載している[RubyMineの公式Wiki| RubyMine](https://pleiades.io/help/ruby/installation-guide.html)についても日本語化されているため、「日本語化をしたことで、公式情報が追いにくくなる」という心配もありません。

個人的にはエディタの中でプログラミングに一般的に利用される英語を学ぶことができるという点から、英語設定のまま使用していますが、 そこは個人の好みで選んで良いでしょう。

もちろんプラグインなので、ON/OFFの切り替えはいつでも可能です。

## Key Promoter X

![](/images/preparation/rubymine-210814-14:41:59.png)

### ショートカットのチェックと記録

- 概要：ショートカットキーがあるメニューを、ショートカットキーなしで使用した場合にポップアップを表示する。また使用回数とミス回数を記録する。
- プラグイン公式：[Key Promoter X \- IntelliJ IDEs Plugin \| JetBrains Marketplace](https://plugins.jetbrains.com/plugin/9792-key-promoter-x)

RubyMineのメニューを使用した際に、もしショートカットがあるメニューであれば、画面右下にポップアップが表示されます。

例えば、Project、つまりファイル一覧は`⌘` + `1`で開くことができるのですが、これをマウスクリックで開くと、ポップアップが表示されます。
「おまえさんは180回もこのショートカットをミスってるね」というメッセージ付きです笑

![](/images/preparation/rubymine-210814-14:47:03.png)

ショートカットをミスした回数の一覧と使用した回数の一覧は画面右側にある「Key PromoterX」のメニューから確認することができます。
先程の`⌘` + `1`は180回ミスして、103回ショートカットで開いていることがわかります。
![](/images/preparation/rubymine-210814-14:56:37.png)

もし「Key PromoterX」が表示されていない場合は、`Shift` + `Shift`でSearchEveryWhere（後述）を呼び出し、「KeyPormoterX」と検索してください。

### ショートカットキーの登録促進

またショートカットが設定されていないプラグインの場合は、「ショートカットを作りませんか？」という提示が出てきます。

例えば下記は、ディスクの内容とRubyMine上で表示されている内容を同期する「Reload from Disk」というメニューを使用したケースです。
こちらにはデフォルトショートカットが割り当てられていないため、ショートカットキー登録のお誘いが出ています。

![](/images/preparation/rubymine-210814-14:50:08.png)

「Reload from Disk（使用したメニューの名前）」を選択することで、ショートカットキー登録のメニューに遷移することができます。

![](/images/preparation/rubymine-210814-15:04:14.png)

※ショートカットキーの登録方法については割愛します。
詳細は[キーボードショートカットを設定する \| RubyMine](https://pleiades.io/help/ruby/configuring-keyboard-and-mouse-shortcuts.html)を参考にしてください。

### ポップアップを停止する

ポップアップがうざったく感じたら、ポップアップに表示されている「Disable alert for this shortcut」を選択することで、通知をオフにすることができます。

また画面左側の「Key Promoter X」にある「Snooze Notifications」からも通知を停止することが可能です。

![](/images/preparation/rubymine-210814-15:10:21.png)

## まとめ

この章では

- プラグインとは
- プラグインの導入方法
- RubyMine習得を手助けしてくれる2つのプラグイン

を紹介しました。

事前準備編の次は初級編です。今回追加したプラグインとともに、学習を進めていきましょう💪

### この章で登場したキーボードショートカット

| ショートカット    | コマンド          |
| ----------------- | ----------------- |
| `⌘` + `,`        | Preferencesを開く |
| `⌘` + `1`        | Projectを開く     |
| `Shift` + `Shift` | SearchEverywhere  |


## もっと知りたいあなたへ

以下から、RubyMineで使用できるプラグインを検索することができます。自分のお気に入りプラグインを探してみてください。
[RubyMine Plugins and Themes \| JetBrains Marketplace](https://plugins.jetbrains.com/ruby)

また本書の番外編でもおすすめプラグインについて紹介する予定です（メンテナンス中）
