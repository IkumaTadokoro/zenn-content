---
title: "Local History"
---

## Local History

ローカルヒストリーはGitのようなバージョン管理ツールとは別に、RubyMine独自でファイルの履歴を取得してくれる仕組みです。

コードの編集、テストの実行、アプリケーションのデプロイなどを行うと、自動的に記録され、RubyMine上で行われた変更とそれ以外（例えばターミナルから削除したとか）の変更のリビジョンが維持されます。

Gitではステージングしていないと基本的に履歴のリカバリが難しいため、もしGitの管理粒度よりも小さなところで履歴を参照したい場合は、Local Historyの機能を使用してみましょう。

:::message
Local Historyは強力なタイムマシンですが、後述の通り保存期間に制限があることと任意のタイミングでの保存ができない制約があります。
そのため、基本的にはGitのようなVCSを使用し、そこでカバーできないものをLocalHistoryでまかなうのが良いでしょう。
:::

## Local Historyを確認する：Show History

![](/images/local-history/rubymine-210822-09:53:26.png)

Local Historyはプロジェクトツールウィンドウまたはエディタのコンテキストメニュー > Local History > Show Local History からアクセスすることができます。

![](/images/local-history/rubymine-210822-09:53:40.png)

エディタ上のコンテキストメニューでは「Show History」の他に、「Show History for selection」というメニューがあります。

![](/images/local-history/how-to-show-local-history-for-selection.gif)

エディタ内で任意のテキストを選択（ドラッグ）した状態で「Show History for selection」を選択することで、指定した箇所についてのLocal Historyだけを確認することができます。

## Local Historyで保存されたバージョンにファイルを戻す:Revert

![](/images/local-history/how-to-apply-local-history.gif)

Local Historyで保存されたバージョンにファイルを戻すには、Show Historyを開いた上で、ファイルを右クリックして「Revert」を選択するか、エディタ上で直接編集します。

![](/images/local-history/rubymine-210822-10:12:36.png)

エディタ上で編集する場合は、差分箇所は以下の色で表示されています。

| 色       | 意味                                                                |
| -------- | ------------------------------------------------------------------- |
| グリーン | 追加（Local Historyにはなかったもの）                               |
| ブルー   | 変更（Local Historyにあったが、現在の版で変更が加えられているもの） |
| グレー   | 削除（Local Historyにあったが、現在の版で削除されたもの）           |

左側のエディタから右側へ伸びている「>>」をクリックすると、Local History上の履歴が現在の版に反映されます。
なおこの矢印を利用せず、現在の版を直接修正することも可能です（例えば、Local Historyの内容を全コピーして、現在の版に貼り付けるなど）

修正が完了次第、Local History画面を閉じることで、内容が反映されます。

## Local Historyにラベルをつける

Local Historyはあくまでタイムスタンプでの保存となるため、特定のリビジョンを作業の起点にしたい場合、少々確認するのが面倒です。 そんな時は各バージョンにラベルをつけることができます。

![](/images/local-history/how-to-put-label-to-history.gif)

「ここの履歴を残したい」と思ったタイミングで、エディタを右クリックし、コンテキストメニュー > Local History > Put Labelを選択します。
ラベル名をOKを押すことで、Local History上にラベルが表示されるようになります。
