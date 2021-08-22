---
title: "ファイル操作"
---

# ファイル操作

このChapterではRubyMineでファイルを扱う際の基本操作について紹介します。

## プロジェクトツールウィンドウの表示：Project（`⌘` + `1`）

プロジェクトツールウィンドウを表示するには、画面左の「Project」を選択するか、ショートカット`⌘` + `1`を利用します。

![](/images/basic-file-operation/how-to-show-project.gif)

このウィンドウが現在扱っているプロジェクトのファイル一覧を表示したエリアになります。

## ファイルツリーの開閉：Expand All / Collapse All（`⌘` + `+` / `⌘` + `-`）

ファイルツリーを展開するにはウィンドウ右上の「Expand All」（`⌘` + `+`）を、ファイルツリーを閉じるには「Collapse All」（`⌘` + `-`）を選択します。

![](/images/basic-file-operation/how-to-expand-and-collapse-file.gif)

ファイル数が多いプロジェクトでは適宜折りたたみつつ、後述のインクリメンタル検索を使用すると良いでしょう。

## ファイルツリー内の移動：Select Previous/Next Node （`↑` / `↓`）

ファイルツリー内を上下するには、方向キーの上下を利用します。
（方向キーがないキーボードの場合はどうするのか未確認です。暫定で後述のインクリメンタル検索を利用することを推奨します）

![](/images/basic-file-operation/how-to-walk-around.gif)

## ファイルのインクリメンタル検索(任意の文字列を入力)

フォーカスがプロジェクトツールウィンドウにある状態で、任意の文字列を入力すると、インクリメンタルサーチが始まります。
この状態では、入力した文字列に合致するファイルもしくはディレクトリのみがハイライトされます。 合致するファイルが複数ある場合は方向キーで選択することが可能です。

![](/images/basic-file-operation/how-to-use-incremental-search-with-project.gif)

## ディレクトリの開閉（ディレクトリを指定して`Enter`）

ディレクトリを指定して`Enter`を押すことで、ディレクトリを開閉することができます。

![](/images/basic-file-operation/how-to-expand-and-collapse-directory.gif)

## 新規ファイル作成：New（`⌘` + `N`）

新規ファイルを作成したいディレクトリを選択して、右クリック -> コンテキストメニューから「New」（`⌘` + `N`）を選択することで新規ファイルを作成できます。 
リストから選択するか、ファイル名に拡張子を指定することで、ファイルの種類を指定することができます。

RubyMineではRubyおよびRails開発においてよく使用するファイルのタイプがリストに表示されています。
リストにはないファイルを作成する際は、ファイルタイプには「File」を選択し、ファイル名で拡張子を指定してください。

![](/images/basic-file-operation/how-to-create-new-file.gif)

## ファイルの削除：Delete（`⌘` + `⌫`）

ファイルの削除は、対象のファイルを選択し`⌘` + `⌫（delete）`で実行します。

![](/images/basic-file-operation/how-to-delete-file.gif)

ファイル削除時に出てくるモーダルは削除対象の参照先を確認するオプションです。
そのまま「OK」を洗濯すればファイルは即削除されますが、「Safe delete」を選択することで、そのファイルの使用先があれば、削除をストップして使用先リストを表示します。

![](/images/basic-file-operation/rubymine-210814-17:12:46.png)

## ファイル名の変更：Rename...（`Shift` + `F6`）

対象のファイルを選択し、コンテキストメニュー > Refactor > Rename...（`Shift` + `F6`）を選択します。

![](/images/basic-file-operation/rubymine-210814-18:24:42.png)

選択後、モーダルウィンドウが表示されます。
ファイル名を変更し、「REFACTOR」を押すことでファイル名の変更が、「Preview」を押すことで変更による影響範囲の確認を行うことができます。

![](/images/basic-file-operation/rubymine-210814-18:26:38.png)

そのファイルが単独で使用されている場合には何も表示されませんが、どこかのファイルで参照されている場合、そのファイル一覧と使用箇所が表示されます。

![](/images/basic-file-operation/rubymine-210814-18:27:21.png)

例えば、`foo.rb`で変更対象のファイル`hoge.rb`を参照していた場合、`foo.rb`の`require hoge`も変更する必要がありますよね。
一般的にIDEにおけるファイル名変更はこういった依存関係を考慮したrenameになるため、リファクタリングのコンテキストに含まれています。

余談ですが、「リファクタリング」というとコードの中身を変更することに注目してしまいがちですが、名前を変更することも立派なりファクタリングなのだと、私はRubyMineから教わりました👍

## ファイルを移動する：Move File...(`F6`)

対象のファイルを選択し、コンテキストメニュー > Refactor > Move File...（`F6`）を選択します。

![](/images/basic-file-operation/how-to-move-file.gif)

メニューを選択することで、モーダルウィンドウが開きます。

![](/images/basic-file-operation/rubymine-210815-16:30:58.png)

- To directory：移動先のディレクトリを選択することができます。`⌃` + `Space`でパスを補完、もしくはプルダウン、「...」からパスを選択することができます。
- Search for references：移動対象のファイルを別のファイルが参照している場合は、ソース中の箇所を検索し、移動とともに修正します。
- Open in editor：移動後に移動したファイルをエディタで開きます。

パスを入力し、「REFACTOR」を選択することでファイルの移動が完了します。

## ファイルを開く

ファイルツリーのファイルを開く方法は、開き方によって数種類あるので、まとめて紹介します。

### ファイルを開く(`Enter`)

ファイルを開く場合は、ファイルを選択して`Enter`を押します。 

![](/images/basic-file-operation/how-to-open-file-simply.gif)

なおマウスクリックによって開く場合、シングルクリックで開くか、ダブルクリックで選択するかを、プロジェクトツールウィンドウの設定（Open Files With Single Click）で選択可能です。
gifでは一度シングルクリックで選択をしてファイルが開かないことを確認した後、設定を変更してシングルクリックでファイルを開いています。

![](/images/basic-file-operation/how-to-configure-file-open-mode.gif)

### プレビューモードで開く：Enable Preview Tab

こちらもプロジェクトツールウィンドウの設定の一つです。
ファイルを選択した際に実際にファイルを開くのではなく、プレビュータブを表示します。

![](/images/basic-file-operation/how-to-configure-preview.gif)

### エディタを分割して開く：Open in Right Split（`Shift` + `Enter`）

ファイルを指定し、コンテキストメニュー > 「Open in Right split」（`Shift` + `Enter`）を選択すると、エディタを分割して選択したファイルを表示します。

![](/images/basic-file-operation/how-to-open-file-split.gif)

### Finderで開く：Reveal in Finder（コンテキストメニュー > Finderで開く）

ファイルを指定し、コンテキストメニュー > 「Finderで開く」を選択します。 Finder上で直接操作したい場合に便利です。

![](/images/basic-file-operation/how-to-open-file-finder.gif)

GitHubにプッシュされているファイルの場合は、同様の手順でGitHubを直接開くことができます。

### 閉じたタブを開く：Reopen Closed Tab

エディタで一度閉じたファイルを再度開く場合は、すでに開いている任意のタブを右クリックし、コンテキストメニュー > 「Reopen Closed Tab」を選択します。
ショートカットが割り当てられていないため、私はキーバインド（`⌃` + `Shift` + `T`）を割り当てていますが、後述の「Recent Files」を利用することで擬似的に代用が可能なので、お好みの方を利用してください。

![](/images/basic-file-operation/how-to-reopen-file.gif)

### 最近開いたファイルを開く：Recent Files（`⌘` + `E`）

`⌘` + `E`で開くことができるポップアップメニュー「Recent Files」からは直近でアクセスしたファイルの一覧が表示されます。
上からアクセス順に表示されていて、ファイルツリー同様に選択・開くことができます。

![](/images/basic-file-operation/how-to-open-recent-files.gif)

なお「Recent Files」はファイル単位ですが、`⌘` +  `Shift` + `E`で開くことができる「Recent Locations」では直近で確認した箇所の一覧を表示することもできます。
「Show edited only」を選択することで、編集した箇所のみを表示することができます。

![](/images/basic-file-operation/how-to-open-recent-locations.gif)

同じような「Recent ...」のメニューが他にもありますので、メニューバーの「View」から探してみてください。
（自分が使いやすいタブを一つ覚えると、ファイルアクセスが格段に早くなります。）

## ファイルを閉じる

ファイルの開き方同様に、ファイルの閉じ方も数種類あります。 ケースに応じて適切な操作を使いましょう。

### アクティブなファイルを閉じる：Close（`⌘` + `w`）

現在使用しているファイルを閉じます。

![](/images/basic-file-operation/how-to-close-file.gif)

### アクティブなファイル以外を閉じる：Close Other Tabs

すでに開いている任意のタブを右クリックし、コンテキストメニュー > 「Close Other Tab」を選択します。
結構頻繁に使いたくなるので、私はショートカットとして（`⌘` + `Shift` + `w`）を割り当てています。
（「すべてのタブを閉じる」アクションについてもショートカットがなく、キー割り当てが難しいため、`⌘` + `Shift` + `w` → `⌘` + `w`のコンボで代用しています。）

![](/images/basic-file-operation/how-to-close-other-file.gif)

## タブを切り替える：Switcher（`⌃` + `Tab`）

エディタがアクティブな状態で、`⌃` + `Tab`を押すことで、開いているエディターとツールウィンドウの一覧が表示されます。
`Tab`を押すことで、開きたいタブを選択し、キーを離すことでカーソルがあるタブを開きます。

![](/images/basic-file-operation/how-to-switch-tab.gif)

## ナビゲーションバーに移動：Jump to NavigationBar（`⌘` + `↑`）

（`⌘` + `↑`）を入力することで、パンくずリストにカーソルをあわせることができます。

![](/images/basic-file-operation/how-to-jump-to-navigation-bar.gif)

キーを入力した段階では、現在のファイル・ディレクトリにフォーカスしますが、方向キーの左右で階層を移動することができます。
階層を指定して方向キーの↓を入力することで、その階層のファイル一覧を選択でき、`Enter`を押すことで、ファイルまたはディレクトリをオープンできます。

## ファイルとエディタの同期：Always Select Opened File

プロジェクトツールウィンドウの設定で「Always Select Opened File」をチェックします。

現在アクティブなファイルが、プロジェクトツールウィンドウのファイルツリー上でもハイライトされるような設定です。

![](/images/basic-file-operation/how-to-configure-sync-editor.gif)

RubyMineはあらゆるところからファイルにアクセスし移動する可能性があるため、個人的には同期を有効にすることをおすすめします。
ただし、こういった同期機能はPCのスペックによっては動作がもっさりとする原因となる可能性があるため、必要に応じて無効化してください。
