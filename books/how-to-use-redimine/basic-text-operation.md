---
title: "エディタ操作"
---

## 履歴からペーストする：Paste from History...（`⌘` + `Shift` + `v`）

通常のコピー&ペーストについては、一般的なアプリ同様に（`⌘` + `c`）、（`⌘` + `v`）でできますが、加えて（`⌘` + `Shift` + `v`）でクリップボードの履歴から貼り付け対象を選択できます。

![](/images/basic-text-operation/how-to-paste-from-history.gif)

## 行頭・行末・単語単位の移動

RubyMineに限らず、ターミナルやブラウザでもそうですが、以下の操作で行頭・行末・単語単位で移動することができます。

- `⌃` + `a`：行頭へ移動
- `⌃` + `e`：行末へ移動
- `⌘` + `←` もしくは `→`：行頭、行末へ移動
- `⌥` + `←` もしくは `→`：単語単位で移動

## 範囲を選択する：Extend Selection / Shrink Selection（`⌥` + `↑`または`↓`）

（`⌥` + `↑`または`↓`）で現在の行を起点として、選択範囲を拡大・縮小することができます。 （`Shift` + `↑`または`↓`
）でも範囲選択はできるのですが、こちらのショートカットを利用すると、意味のある範囲で（例：インデントが同じ、ブロックが同じ）範囲を拡大・縮小してくれます。

![](/images/basic-text-operation/how-to-select-range.gif)

## 行を複製する：Duplicate Line（`⌘` + `D`）

複製したい行を選択した状態で、（`⌘` + `D`）を入力します。 複数行を指定すると、その単位で複製することができます。

![](/images/basic-text-operation/how-to-duplicate-line.gif)

## 新しい行を挿入する：Start New Line（`Shift` + `Enter`）

（`Shift` + `Enter`）を入力することで、どの位置（つまり行頭や行末でない場所）でも新しい行を開始することができます。 gifでは行途中で`Enter`を入力した場合と（`Shift` + `Enter`
）を入力した場合を表示しています。

![](/images/basic-text-operation/how-to-insert-new-line.gif)

## 現在の行を削除する：Delete Line（`⌘` + `⌫`）

（`⌘` + `⌫`）を入力することで、どの位置（つまり行頭や行末でない場所）でもカーソルのある行を削除することができます。

![](/images/basic-text-operation/how-to-delete-line.gif)

## 行を移動する：Move Line Up / Move Line Down（`⌥` + `Shift` + `↑`または`↓`）

（`⌥` + `Shift` + `↑`または`↓`）を入力することで、カーソルがある行を上下に移動することができます。 複数行を選択した場合、その単位で移動することができます。

![](/images/basic-text-operation/how-to-move-line.gif)

## メソッドを移動する：Move Statement Up / Move Statement Down（`⌘` + `Shift` + `↑`または`↓`）

（`⌘` + `Shift` + `↑`または`↓`）を入力することで、メソッドを範囲選択なしで移動することができます。 privateメソッドに移動するときや、メソッドの順序を整理する際に便利です。
なお、カーソル位置はメソッドの開始行（`def`がある行）にある必要があります。

![](/images/basic-text-operation/how-to-move-method.gif)

## インデントを調整する：Tab / Unindent Line or Selection（`Tab`/`Shift` + `Tab`）

`Tab`/`Shift` + `Tab`でインデントの追加・削除を行うことができます。 範囲を選択していれば、その範囲ごとインデントします。

![](/images/basic-text-operation/how-to-indent.gif)

## コメントアウト：Comment with line comment（`⌘` + `/`）

（`⌘` + `/`）でコメント化/コメントの解除ができます。

## マルチカーソル：Clone Caret Above / Clone Caret Below

VSCodeは（`⌃` + `⌥` + `↑` or `↓`）でマルチカーソルを複製できるのですが、RubyMineにはデフォルトでマルチカーソルのキーボードショートカットがありません。 一応`⌥`
を選択したままクリックをすることで、カーソルの複製はできますが、結構面倒なのでキーボードショートカットを設定することをおすすめします。

![](/images/basic-text-operation/rubymine-210815-19:41:38.png)

アクション名は「Clone Caret Above」と「Clone Caret Below」です。 ※キーボードショートカットの設定の仕方は「（メンテナンス中）」

![](/images/basic-text-operation/how-to-duplicate-cursor.gif)

上のgifの通り、私は（`⌃` + `⌘` + `Shift` + `↑` or `↓`）を設定していますが、使いやすいキーを設定してください。

またマルチカーソルとは別に、同じ単語にカーソルを複製するマルチキャレット機能もあります。 こちらは単語の語頭にカーソルをおいた状態で（`⌃` + `G`/`⌃` + `Shift` + `G`）を入力することで、カーソルが複製されます。

![](/images/basic-text-operation/how-to-use-mulit-caret.gif)

## インテリセンス：Code completion（`⌃` + `Space`）

記述中のソースに対して、RubyMineが候補を表示し、それを選択することができる機能です。

まず候補を表示する方法は2つあります。下図では一度自動補完を`esc`で打ち切ったあと、再度候補を表示しています。

![](/images/basic-text-operation/how-to-use-intellisense1.gif)

1. 入力中に自動で表示される
2. 補完をしたい箇所にカーソルをおき、（`⌃` + `Space`）を入力する

基本的には入力中の候補を利用するのがいいと思います。 次に表示された候補を方向キーで選択し、それをソースに反映するのですが、ここも補完方法が2種類あります。 gifでは`Enter`、`Tab`の順で表示しています。

![](/images/basic-text-operation/how-to-use-intellisense2.gif)

1. `Tab`：入力箇所にあった単語を、指定した候補に置き換える
2. `Enter`：指定した候補を挿入する

## コンテキストアクション：Show Context Action（`⌥` + `Enter`）

ソースコードに修正可能な場所がある場合に利用できるアクションです。 例えば、以下のソースにおける最後の変数`num`は冗長な戻り値であるため不要です。

```ruby

def hoge
  array.map { |num| num.to_s }
end
```

こういった記法上の間違いをRubyMineが検出し、波線を表示してくれます。

![](/images/basic-text-operation/how-to-use-context-action.gif)

カーソルを当てることで「なぜ修正が必要なのか」、（`⌥` + `Enter`）を実行することで、修正候補の提示と自動修正を行ってくれます。

検出される値は、Rubyそのものの文法としての誤り（RubyMineが認知）と、Rubocopが指摘するスタイルの修正の2種類があります。
Rubocopの指摘は基本的に自動でONになっていますが、OFFになっている場合は、Preferences > Editor > Inspection > Rubocopにチェックを入れる必要があります。

![](/images/basic-text-operation/rubymine-210815-20:09:46.png)

## Insert Live template（`⌘` + `J`）

![](/images/basic-text-operation/how-to-use-live-template.gif)

（`⌘` + `J`）を入力することで、Live templateと呼ばれるRubyMineに登録されたスニペットを呼び出すことができます。 表示された候補を方向キーで選択し、`Enter`
を入力することで、選択したテンプレートを挿入します。

![](/images/basic-text-operation/rubymine-210821-23:30:12.png)

なお使用できるLive templateの一覧の確認および追加は Preferences（`⌘` + `,`） > Editor > Live Templates から行うことができます。

## 文字列を検索/置換する

### 開いているファイル内を検索/置換する：Find / Replace（`⌘` + `F` / `⌘` + `R`）

開いているファイルを検索するには（`⌘` + `F`）を、検索した文字列を置換するには（`⌘` + `R`）を入力します。

![](/images/basic-text-operation/how-to-use-find-and-replace-in-file.gif)

### プロジェクト全体をGrep検索/置換する：Find in Files / Replace in Files（`⌘` +  `Shift` + `F` / `⌘` + `Shift` + `R`）

検索範囲をファイルだけではなく、プロジェクト全体に広げるには`Shift`を入力に追加します。

![](/images/basic-text-operation/rubymine-210815-20:20:21.png)

デフォルトでは「In Project」がハイライトされていますが、「Module」「Directory」「Scope」と指定範囲を変更することも可能です。

## Quick Documentation（`F1` | みたい箇所にカーソルホバー）

![](/images/basic-text-operation/how-to-use-quick-documentation.gif)

メソッドや変数にカーソルを合わせて数秒待つ、もしくは`F1`を入力することで、簡単な定義情報を確認することができます。 引数の数や順番を確認したい時に便利です。

## 定義元または使用箇所へジャンプ：Go to Declaration or Usage（`⌘` + `B`）

![](/images/basic-text-operation/how-to-code-jump.gif)

メソッドや変数にカーソルを合わせ（`⌘` + `B`）を入力するか、（`⌘` + `Click`）することで、そのメソッドや変数の定義元にジャンプすることができます。 定義元がない場合はそれを使用している範囲が選択肢として表示されます。

プロジェクトが大きくなってきたり、外部ライブラリを使用する場合に利用したい機能です。 （特にRailsでは内部実装を確認するのにとても役立ちます）

## レンズモード：Show code lens on scrollbar hover（スクロールバーにカーソルを合わせる）

ファイルの行数が多い時に内容を確認する場合は、レンズ機能を使用するのが便利です（VSCodeのミニマップみたいなものです）。

![](/images/basic-text-operation/how-to-use-lens.gif)

スクロールバーの上にカーソルを合わせることで、実際にスクロールしなくても、ファイルの中身を覗き見ることができます。 なおデフォルトでこの機能はONですが、OFFになっている場合はスクロールバーを右クリックして、「Show code lens
on scrollbar hover」をチェックする必要があります。

## 大文字・小文字を切り替える：Toggle Case（`⌘` + `Shift` + `U`）・スネークケース・キャメルケースの切り替え：Toggle Camel/Snake Case（`option` + `Shift` + `U`）

（`⌘` + `Shift` + `U`）で選択箇所の大文字と小文字、（`option` + `Shift` + `U`）で選択箇所のスネークケース・キャメルケースを切り替えます

![](/images/basic-text-operation/how-to-toggl-case.gif)
![](/images/basic-text-operation/how-to-toggl-case.gif)

## コードフォーマット：Reformat Code（`⌘` + `⌥` + `L`）

コードの自動フォーマットを実行するには、（`⌘` + `⌥` + `L`）を入力します。

![](/images/basic-text-operation/how-to-use-code-format.gif)

## ブロックで囲む：Surround With（`⌘` + `⌥` + `T`）

ifブロックや例外ブロックを作成するには（`⌘` + `⌥` + `T`）を入力して、挿入したいブロックを選択します。 大きなifブロックはendの挿入位置でエラーになることもあるので、自動入力できると嬉しい時があります。

![](/images/basic-text-operation/how-to-use-surrond.gif)

## コードの展開/縮小

### 選択したブロックの展開/縮小：Expand/Collapse（`⌘` + `+` / `-`）

長いメソッドがあると、全体の見通しが悪くなるケースがあります。 そんな時はコードブロックにカーソルをおいて展開/縮小（`⌘` + `+` / `-`）して見通しをよくしましょう。

![](/images/basic-text-operation/how-to-use-expand-and-collapse-block.gif)

### ファイル全体の展開/縮小：Expand All/Collapse All（`⌘` + `Shift` + `+` / `-`）

ファイル全体を折り畳む場合は（`⌘` + `Shift` + `+` / `-`）を利用します。

![](/images/basic-text-operation/how-to-use-expand-and-collapse-file.gif)

### ファイル構造の表示：File Structure（ツールウィンドウ：`⌘` + `7`、プレビュー：`⌘` + `F12`）

![](/images/basic-text-operation/how-to-show-structure.gif)

画面左下の「Structure」を選択（`⌘` + `7`）することで、Structureツールウィンドウを表示することができます。
ソースコードであればクラス構造が、マークダウンであれば目次が、というように開いているファイルの構成を開くことができます。

各構成要素はクリックすることでエディタに開くことができます。

![](/images/basic-text-operation/how-to-show-structure2.gif)

またツールウィンドウに表示するのではなく、プレビューで表示したいのであれば、（`⌘` + `F12`）を入力することで表示可能です。
