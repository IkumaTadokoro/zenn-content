---
title: "Run Anything"
---

## Run Anything（`⌃` + `⌃`）

（`⌃` + `⌃`）を入力することで、「Run Anything」を起動することができます。

その名の通り、bundlerやirb起動など、ターミナルで実行できるコマンド類をなんでも実行することができます。

![](/images/run-anything/how-to-run-anything.gif)

## ターミナルやSearch EveryWhereでの実行との違い

コマンドはターミナルまたはSearch EveryWhereからでも実行できますが、Run Anythingを使用したコマンド実行は以下の違いがあります。

### コマンドの実行に特化している

これはSearch EveryWhereとの差別点になりますが、Run Anythingはコマンドの実行に特化しているため、余計な実行候補（例えば「bundlerの設定」などが表示されず、効率的に作業を行うことができます。

### 実行履歴が残る

Run Anythingで実行したコマンドはプロジェクト単位で履歴が残ります。定期的に実行するコマンドがある場合、そのプロジェクトにあった履歴から実行できるため便利です。
gifの例ではローカルで書いた記事をPreviewするための`npx zenn preview`を起動しています。

![](/images/run-anything/how-to-run-anything-with-history.gif)

### 最近開いたプロジェクトを開く

Run Anythingの画面で`open`と入力することで、最近開いたプロジェクト一覧が表示されます。
開きたいプロジェクトを選択することで、RubyMineエディタ上から別のプロジェクトを開くことができます。

![](/images/run-anything/how-to-open-project-with-run-anything.gif)

:::message
RubyMineにはCLIもあり、ターミナルからRubyMineプロジェクトを開くこともできます。
参考：[コマンドラインインターフェース \| RubyMine](https://pleiades.io/help/ruby/working-with-the-ide-features-from-command-line.html)
:::

### オプションを補完してくれる

Rails系のコマンドでは、コマンドを途中まで入力した段階で、そのコマンドにカーソルを合わせ`Enter`を入力すると、オプションや引数を設定するモーダルが開きます。

![](/images/run-anything/how-to-run-anything-rails-command.gif)

## 最終的にはお好みで

ターミナルを利用するか、Run Anythingを利用するかはお好みですが、個人的にはプロジェクトごとに履歴が残るので、Run Anythingがおすすめです。
（bundlerとかnpmとか何回も実行するコマンドを、`⌃`2回で実行できるのは結構楽ですよ）
