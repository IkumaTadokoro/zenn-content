---
title: "Git"
---

## バージョン管理（Git）の有効化：Enable Version Control Integration

RubyMineでバージョン管理（Git）の機能を使用するには、まず有効化する必要があります。

1. VCS操作のポップアップメニューを開く（`⌃` + `V`）か、メニューバーの「VSC」から「Enable Version Control Integration...」を選択します。
2. プルダウンで「Git」が選択されていることを確認し、「OK」を選択します。

![](/images/git/how-to-activate-vcs.gif)

以降、VCS用のメニューがGit専用のものに置き換わります。

## ステージングに関する設定：Enable staging area

コマンドラインでGitを利用している場合、

1. 作業ディレクトリ 
2. ステージングエリア
3. ローカルリポジトリ

という3ステップが必要になりますが、 RubyMineでは以下の2ステップで変更をローカルリポジトリに反映することができます。

1. Changelist
2. ローカルリポジトリ

RubyMine 2020.3 まではこの2ステップ式しかなかったのですが、以降はどちらの方式も採択できるようになりました。
Preferences...（`⌘` + `,`）> Version Control > Git > 「Enable staging area」をON/OFFにすることで切り替えが可能です。
（ONの場合、前者の方法でローカルリポジトリへの反映を行います）

![](/images/git/rubymine-210817-10:40:37.png)

- RubyMineを使用していない開発者は基本的にステージングエリアを使用していること
- ステージングエリアを使用した方がGit本来の恩恵を受けやすく、小回りが効きやすい

という理由から以降の説明では、「Enable staging area」がONになっている想定で説明を進めます。 なおOFFになっている場合も、「add」がないだけで他の箇所は同じです。

## コミットツールウィンドウ：Commit（`⌘` + `0`）

（`⌘` + `0`）でコミットツールウィンドウを開くことができます。画面左にある「Commit」とあるタブを選択することでも開くことができます。

![](/images/git/rubymine-210817-10:58:08.png)

| 番号 | 名前           | 内容                                       |
| ---- | -------------- | ------------------------------------------ |
| 1    | Staged         | ステージングエリアにあるファイルを表示する |
| 2    | Unstaged       | 作業ディレクトリにあるファイルを表示する   |
| 3    | Commit Message | コミットメッセージを記入する               |

ステージングエリア・作業ディレクトリにあるファイルは、Group By設定を切り替えることで、ファイル名だけを表示するか、ディレクトリごとにグループ化して表示することができます。

![](/images/git/how-to-switch-group-by.gif)

個人的にはファイル別に表示する方が見やすいですが、好みに合わせて切り替えてください。

## diffの確認：Show Diff（`⌘` + `D`）

コミットツールウィンドウでファイルを選択し、「Show Diff（`⌘` + `D`）」を押すことで、エディタにdiffを表示することができます。
変更がある箇所がハイライトされており、ガターにある「>>」「<<」を押すことで、エディタを見ながらadd（作業ディレクトリにある場合）・commit（ステージングエリアにある場合）をすることが可能です。

gifでは、作業ディレクトリでの作業内容を表示してエディタ上でaddし、ステージングエリアに反映されることを確認しています。

![](/images/git/how-to-show-diff-by.gif)

## 作業ディレクトリから削除：Delete（`⌫`）

ファイルを作業ディレクトリから削除する場合は、ファイルを右クリックし、コンテキストメニューから「Delete」（`⌫`）を選択します。

![](/images/git/how-to-delete-from-unstaged.gif)

## add：Stage（`⌘` + `⌥` + `A`） / addの取り消し：Unstage（`⌘` + `⌥` + `Z`）

addするにはUnstagedにあるファイルを右クリックし、コンテキストメニューから「Stage」（`⌘` + `⌥` + `A`）を選択します。
また一度addした内容を取り消す（作業ディレクトリに戻す）には、コンテキストメニューから「UnStage」（`⌘` + `⌥` + `Z`）を選択します。

![](/images/git/how-to-stage.gif)

「UnStaged」にカーソルを合わせてStageを行うことで、作業ディレクトリにあるファイルを一括でaddすることができます。

![](/images/git/how-to-stage-all.gif)

## commit（`⌘` + `Enter`）

commitするにはstagedにファイルがある状態で、コミットメッセージを入力し、「COMMIT」（`⌘` + `Enter`）を入力します。

![](/images/git/how-to-commit.gif)

:::message
2021/10/01 追記
マウスを使用せずに、コミットメッセージを入力するエリアにカーソルを移動するには、次の二つの方法があります。

1. ステージングにカーソルがある状態で、`Tab`キーを入力する
2. `⌘` + `K`を入力する
:::

### commit --amend（`⌃` + `⌥` + `M`）

「Amend」にチェックを入れて（`⌃` + `⌥` + `M`）commitすることで、直前のコミットに今回のコミットをまとめることができます。
Stagedにファイルがない状態でも、直前のコミットメッセージを修正したい場合などに重宝します。

![](/images/git/how-to-amend-commit.gif)

### コミット前のチェック設定：Show Commit Option

「Show Commit Option」からコミット時の設定を登録することができます。
デフォルトではファイルの中に「TODO」が残っている場合は、コミットを中断して注意を促すようになっています。

![](/images/git/how-to-configure-commit-option.gif)

「COMMIT ANYWAY」を選択することで、チェックされた内容を無視してcommitすることができます。

:::message
ブランチを切って作業を始める際に、空コミットをしたい場合があるかもしれませんが、RubyMineでは空コミットが登録できません。 Run Anythingまたはターミナルから、従来通りコマンドを入力して空コミットを登録してください。
```bash
% git commit --allow-empty -m <コミットメッセージ>
```
:::

## バージョン管理ウィンドウ：Git（`⌘` + `9`）

（`⌘` + `9`）を入力もしくは画面下の「Git」タブを選択することで、バージョン管理ウィンドウを開くことができます。

![](/images/git/rubymine-210817-12:03:04.png)

| 番号 | 概要                                                                 |
| ---- | -------------------------------------------------------------------- |
| 1    | ブランチ一覧                                                         |
| 2    | コミットログ一覧。赤枠で指定した条件でフィルタリングすることが可能。 |
| 3    | 選択したコミットに含まれるファイル                                   |
| 4    | コミットメッセージ                                                   |

## ブランチを切る：New branch

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「New Branch from Selected...」を選択します。
ブランチ名を入力して「OK」を選択すると、新しいブランチが作成されます。

![](/images/git/how-to-create-branch.gif)

## ブランチを切り替える

![](/images/git/how-to-switch-branch.gif)

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Checkout」を選択します。

![](/images/git/rubymine-210822-11:28:30.png)

Search Everywhereを使用するのであれば、「Branches...」を検索することでブランチ一覧に遷移できます。

![](/images/git/rubymine-210822-11:28:49.png)

Checkoutしたいブランチを選択し、「Checkout」を選択することで切り替えが可能です。

## ブランチを削除する：Delete

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Delete」を選択します。

![](/images/git/how-to-delete-branch.gif)

## ブランチ名を変更する：Rename...

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Rename..」を選択します。
ブランチ名を入力して「OK」を選択すると、ブランチ名が変更されます。

![](/images/git/how-to-rename-branch.gif)

## コミットメッセージを変更する：Edit Commit Messages...（`F2`）

コミット一覧から変更対象のコミットを右クリックし、コンテキストメニューから「Edit Commit Message...」（`F2`）を選択します。
コミットメッセージを入力して、「OK」を選択すると、コミットメッセージが変更されます。

![](/images/git/how-to-edit-commit-message.gif)

## GitHubアカウントを設定する

Preferences（`⌘` + `,`） > Version Control > Github を選択し、「+」ボタンからお好みの方法でGithubアカウントをRubyMineに紐付けます。

![](/images/git/rubymine-210817-14:30:30.png)

※だいぶ前にGithubアカウントを連携したので、この先を詳細に覚えておらずすみません...。おそらく表示される内容の通りに作業をすれば問題なく登録できるかと思います。

## リモートリポジトリの設定：Manage Remotes

メニューバー Git > Manage Remotes...を選択します。

![](/images/git/rubymine-210817-14:36:01.png)

「+」ボタンを押して、登録するリモートリポジトリのエイリアス名とURLを登録します。

![](/images/git/rubymine-210817-14:38:09.png)

ここで登録したリモートリポジトリを、push、pull時に選択することが可能になります。
例えば、あるリポジトリをforkして自分のリポジトリにしている場合、fork元のリポジトリを「upstream」、forkしたリポジトリを「origin」とすることで、pullは「upstream」から、pushは「origin」を指定することが可能になります。

## push（`⌘` + `Shift` + `K`）

（`⌘` + `Shift` + `K`）を入力することで、Push画面を表示することができます。
画面左側にはPush先と対象のコミット一覧が、画面右側にはコミットごとのDiffが表示されています。

![](/images/git/how-to-push.gif)

Push先はクリックすることで変更でき、まだ登録されていないリモートリポジトリの場合は、この画面から登録することも可能です。
リモートリポジトリが作成されていない場合は、RubyMineが同名のブランチをリモートリポジトリに作成し、pushを行います。

対象を確認後、「PUSH」を選択する（`⌘` + `Enter`）ことでPushを実行することができます。このとき、プルダウンから「Force Push」も選択可能です。

## Pull Requests

Githubを開かずに、RubyMine上からPull Requestsを閲覧・作成することが可能です。

### Pull Requestsツールウィンドウの表示：Pull Requests

RubyMine上でPull Request関連の機能を利用するには、Pull Requestツールウィンドウを有効にする必要があります。

メニューバーから View > Tool Window > Pull Requestsを選択し、Pull Requestsツールウィンドウを有効化します。

![](/images/git/rubymine-210821-18:41:00.png)

以降は画面左にある「Pull Requests」を選択することで、Pull Requestsツールウィンドウを有効化することができます。

![](/images/git/rubymine-210821-18:42:02.png)

### Pull Requestの閲覧

Pull Requestsツールウィンドウを開くと、Pull Requestsの一覧が表示されています。

![](/images/git/rubymine-210821-18:49:40.png)

初期状態では、「state:open」でフィルターがかかっていますが、クリアすることでクローズしたプルリクも参照することができます。
また表示情報が古い場合には、`⌘` + `R`を入力することで、PR一覧を更新することができます。

![](/images/git/how-to-filter-pr.gif)

`key:検索値`の形で入力することで、state以外のフィルターをかけることができます。使用できるパラメータは`⌃` + `Space`で表示することができます。

![](/images/git/how-to-show-pr-details.gif)

一覧から対象のPRを選択することで、PRの詳細が表示され、エディタにConversationの詳細が表示されます。

Pull Requestsツールウィンドウでは、PRの詳細（Info）、PRに含まれるファイル（Files）、PRに含まれるコミット（Commits）を参照することができます。
エディタに表示されているConversationでは、メッセージの編集・追記を行うことができます。

![](/images/git/rubymine-210821-18:56:28.png)

なおPRをGithub上で確認したいときや、Conversationsのタブを閉じてしまったときは、Pull Requestツールウィンドウを右クリックし、コンテキストメニューから選択してください。

### Pull Requestの作成（`⌘` + `N`）

![](/images/git/how-to-create-pr.gif)

PRを作成するには、Pull Requestツールウィンドウ右上の「+」ボタンを選択（`⌘` + `N`）します。
あとはGithubで作成する際と同じで、以下の内容を入力します。

- PRするブランチ
- タイトル
- 内容
- レビュワー
- アサイン
- ラベル

通常のPRを作成する場合は「CREATE PULL REQUEST」を、ドラフトPRを作成するにはプルダウンから「Create Draft PULL REQUEST」を選択してPRを作成します。

## Gistを作成する：Create Gist...

pushの番外編的なところで、RubyMineからGistを作成することもできます。

![](/images/git/rubymine-210821-19:25:02.png)

プロジェクトツールウィンドウで、Gistを作成するファイルを右クリックし、ポップアップメニュー > Create Gistを選択します。

![](/images/git/rubymine-210821-19:28:01.png)
![](/images/git/rubymine-210821-19:28:27.png)

適宜選択してOKを選択することで、Gistを作成することができます。 

なお、ディレクトリを選択してこのメニューを呼び出すことで、一つのGistに複数のファイルを一括でアップロードすることが可能です。

## fetch / pull / Update Project...（`⌘` + `T`）

いずれもリモートリポジトリの情報をローカルリポジトリに対して反映する方法です。

| 名前               | 概要                                                         | 操作方法                 |
| ------------------ | ------------------------------------------------------------ | ------------------------ |
| Fetch              | リモートブランチの情報を更新する。ローカルには反映しない     | メニューバー Git > Fetch |
| Pull               | 指定したリモートブランチの情報を更新し、ローカルに反映する。 | メニューバー Git > Pull  |
| Update Project | プロジェクト内のすべてのブランチに対して、Pullを実行する     | `⌘` + `T`               |

Pullは通常のPullコマンド同様に、ブランチやオプションを指定することができます。

![](/images/git/rubymine-210817-14:59:57.png)

Update Projectについても、取り込み時にマージするか、リベースするかを選択することができます。

![](/images/git/rubymine-210817-15:02:44.png)

## stash

現在のブランチで作業している内容を一時退避したい場合には、stashコマンドを利用します。

![](/images/git/how-to-stash.gif)

RubyMineでは、Gitのポップアップメニュー（`⌃` + `V`） > Stash Changes... を選択することで起動できます。
メッセージを入力し、「CREATE STASH」を選択することで作業を一時退避することができます。

退避した作業の確認・復旧・削除を行いたい場合は、「Unstash Changes...」を利用します。

![](/images/git/how-to-Unstash.gif)

RubyMineでは、Gitのポップアップメニュー（`⌃` + `V`） > Unstash Changes... を選択することで起動できます。
stashの一覧が表示されますので、対象のstashを選択して、必要に応じて以下から選択します。

- 「VIEW」（確認）
- 「DROP」（削除）
- 「CLEAR」（stashの全件削除）
- 「APPLY STASH」（stashの反映：`stash apply`）

## reset

作業を特定のコミットまで戻したい際には、resetコマンドを使用します。
RubyMineではバージョン管理ウィンドウでコミットを指定することで、resetコマンドを起動します。

![](/images/git/how-to-reset.gif)

バージョン管理ウィンドウ（`⌘` + `9`） > 戻したい時点のコミットを右クリックし、コンテキストメニューから「Reset Current Branch to Here」を選択します。

resetコマンドのオプション（Soft、Mix、Hard、Keep）が表示されますので、戻したい状態に応じて選択しOKを押します。

:::message
オプションの意味は通常のgit resetと同じです
:::

これで指定したオプションに応じて、作業内容が元に戻ります。SHA1 IDを`git reflog`で確認する必要がないので楽ちんですね。

### Drop Commit

![](/images/git/rubymine-210821-20:13:44.png)

同じくバージョン管理ウィンドウでコミットを指定して利用できるメニューに「Drop Commit」というメニューがあります。 これを選択することで、指定したコミットを破棄することができます。
（リポジトリ、ステージングエリア、作業ディレクトリから削除されるので注意してください。）

なお、実際に動作しているコマンドは`git reset --hard`であるため、resetと合わせて紹介しました。


## rebase

### 作業ブランチ内でrebaseを行う

```
      A---B---C topic
     /
D---E main
```

```
      A---B(B---C) topic
     /
D---E main
```

作業中のブランチにおいて、rebaseを行いたい場合は以下のように作業します。

![](/images/git/rubymine-210821-20:50:28.png)

1. バージョン管理ウィンドウでrebaseの起点にしたいコミットを右クリックし、コンテキストメニューから「Interactive Rabase from Here...」を選択します。

![](/images/git/how-to-rebase-at-current-branch.gif)

2. rebaseのためのウィンドウが開きます。各コミットが時系列で表示されており、ドラッグ & ドロップで順序を変更することが可能です。必要に応じてコミットを選択した状態で各ボタンを選択します。「Reset」を選択すると、行った操作をリセットすることができます。

:::message
git rebase -i 同様、以下の操作が可能です。
- REWORDS（コミットメッセージの編集）
- SQUASH（コミットを一つにまとめ、メッセージも修正する）
- FIXUP（コミットを一つにまとめる。コミットメッセージは修正しない）
- DROP（コミットの削除）
:::

3. 「START REBASING」を選択すると、rebaseが始まります。rebaseの結果コンフリクトが生じる場合は、エディタが立ち上がるので都度解消していきます。

### ブランチ間でrebaseを行う

```
      A---B---C topic
     /
D---E---F---G main
```

```
              A'---B'---C' topic
             /
D---E---F---G main
```

あるブランチでの変更を、現在のブランチに取り込みたい場合はブランチ一覧からrebaseを利用します。

![](/images/git/rubymine-210821-21:11:00.png)

取り込みたい作業内容のあるブランチを右クリックし、コンテキストメニュー > 「Rebase Current Onto Selected」を選択します。

![](/images/git/rubymine-210821-21:13:00.png)

選択したブランチでの作業内容が、カレントブランチにrebaseで取り込まれます。

## cherry-pick

別ブランチの特定のコミットを取り込みたい場合は、cherry-pickコマンドを使用します。
RubyMineではバージョン管理ウィンドウでコミットを選択することで、cherry-pickコマンドを起動します。

![](/images/git/how-to-show-all-branches-log.gif)

必須ではありませんが、cherry-pickを行う場合は全ブランチのコミット履歴をみられるようにしておくことをおすすめします。

取り込みたいコミットを右クリックし、コンテキストメニューから「Cherry-Pick」を選択します。 これで指定したコミットがカレントブランチに取り込まれます。

## revert

コミット済みの内容を打ち消ししたい場合はrevertコマンドを使います。

RubyMineではバージョン管理ウィンドウでコミットを指定することで、revertコマンドを起動します。

![](/images/git/how-to-revert.gif)

バージョン管理ウィンドウ（`⌘` + `9`） > 打ち消したいコミットを右クリックし、コンテキストメニューから「Revert Commit」を選択します。 選択したコミットの打ち消しコミットが自動で作成されます。

## 番外編：実行されているコマンドの確認

RubyMineで行っているGit操作はGUI上で行うことができますが、「これをCUIで行ったらどうなるのだろうか？」と思う日もあるでしょう。
そんな時は、バージョン管理ウィンドウの「Console」タブを開いてみましょう。

![](/images/git/rubymine-210822-11:35:40.png)

これまで行われてきたGitコマンドが時系列で表示されています。IDE経由のため、実際のコマンドよりも少しいろいろと書いてありますが、最後の方だけを見れば、およそどんなコマンドが実行されているか理解することができるでしょう。
