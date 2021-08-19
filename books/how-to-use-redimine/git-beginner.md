---
title: "Git操作（初級編）"
---

:::message
この章では基本的なGit操作を紹介します
:::

## バージョン管理（Git）の有効化（Enable Version Control Integration）

RubyMineでバージョン管理（Git）の機能を使用するには、まず有効化する必要があります。

1. VCS操作のポップアップメニューを開く（`⌃` + `V`）か、メニューバーの「VSC」から「Enable Version Control Integration...」を選択します。
2. プルダウンで「Git」が選択されていることを確認し、「OK」を選択します。

![](/images/git-beginner/how-to-activate-vcs.gif)

以降、VCS用のメニューがGit専用のものに置き換わります。

## ステージングに関する設定（Enable staging area）

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

![](/images/git-beginner/rubymine-210817-10:40:37.png)

- RubyMineを使用していない開発者は基本的にステージングエリアを使用していること
- ステージングエリアを使用した方がGit本来の恩恵を受けやすく、小回りが効きやすい

という理由から以降の説明では、「Enable staging area」がONになっている想定で説明を進めます。 なおOFFになっている場合も、「add」がないだけで他の箇所は同じです。

## コミットツールウィンドウ（`⌘` + `0`）

（`⌘` + `0`）でコミットツールウィンドウを開くことができます。画面左にある「Commit」とあるタブを選択することでも開くことができます。

![](/images/git-beginner/rubymine-210817-10:58:08.png)

| 番号 | 名前           | 内容                                       |
| ---- | -------------- | ------------------------------------------ |
| 1    | Staged         | ステージングエリアにあるファイルを表示する |
| 2    | Unstaged       | 作業ディレクトリにあるファイルを表示する   |
| 3    | Commit Message | コミットメッセージを記入する               |

ステージングエリア・作業ディレクトリにあるファイルは、Group By設定を切り替えることで、ファイル名だけを表示するか、ディレクトリごとにグループ化して表示することができます。

![](/images/git-beginner/how-to-switch-group-by.gif)

個人的にはファイル別に表示する方が見やすいですが、好みに合わせて切り替えてください。

## diffの確認（`⌘` + `D`）

コミットツールウィンドウでファイルを選択し、「Show Diff（`⌘` + `D`）」を押すことで、エディタにdiffを表示することができます。
変更がある箇所がハイライトされており、ガターにある「>>」「<<」を押すことで、エディタを見ながらadd（作業ディレクトリにある場合）・commit（ステージングエリアにある場合）をすることが可能です。

gifでは、作業ディレクトリでの作業内容を表示してエディタ上でaddし、ステージングエリアに反映されることを確認しています。

![](/images/git-beginner/how-to-show-diff-by.gif)

## 作業ディレクトリから削除（`⌫`）

ファイルを作業ディレクトリから削除する場合は、ファイルを右クリックし、コンテキストメニューから「Delete」（`⌫`）を選択します。

![](/images/git-beginner/how-to-delete-from-unstaged.gif)

## add（`⌘` + `⌥` + `A`） / addの取り消し（`⌘` + `⌥` + `Z`）

addするにはUnstagedにあるファイルを右クリックし、コンテキストメニューから「Stage」（`⌘` + `⌥` + `A`）を選択します。
また一度addした内容を取り消す（作業ディレクトリに戻す）には、コンテキストメニューから「UnStage」（`⌘` + `⌥` + `Z`）を選択します。

![](/images/git-beginner/how-to-stage.gif)

「UnStaged」にカーソルを合わせてStageを行うことで、作業ディレクトリにあるファイルを一括でaddすることができます。

![](/images/git-beginner/how-to-stage-all.gif)

## commit（`⌘` + `Enter`）

commitするにはstagedにファイルがある状態で、コミットメッセージを入力し、「COMMIT」（`⌘` + `Enter`）を入力します。

![](/images/git-beginner/how-to-commit.gif)

### commit --amend（`⌃` + `⌥` + `M`）

「Amend」にチェックを入れて（`⌃` + `⌥` + `M`）commitすることで、直前のコミットに今回のコミットをまとめることができます。
Stagedにファイルがない状態でも、直前のコミットメッセージを修正したい場合などに重宝します。

![](/images/git-beginner/how-to-amend-commit.gif)

### コミット前のチェック設定（Show Commit Option）

「Show Commit Option」からコミット時の設定を登録することができます。
デフォルトではファイルの中に「TODO」が残っている場合は、コミットを中断して注意を促すようになっています。

![](/images/git-beginner/how-to-configure-commit-option.gif)

「COMMIT ANYWAY」を選択することで、チェックされた内容を無視してcommitすることができます。

## バージョン管理ウィンドウ（`⌘` + `9`）

（`⌘` + `9`）を入力もしくは画面下の「Git」タブを選択することで、バージョン管理ウィンドウを開くことができます。

![](/images/git-beginner/rubymine-210817-12:03:04.png)

| 番号 | 概要                                                                 |
| ---- | -------------------------------------------------------------------- |
| 1    | ブランチ一覧                                                         |
| 2    | コミットログ一覧。赤枠で指定した条件でフィルタリングすることが可能。 |
| 3    | 選択したコミットに含まれるファイル                                   |
| 4    | コミットメッセージ                                                   |

## ブランチを切る

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「New Branch from Selected...」を選択します。
ブランチ名を入力して「OK」を選択すると、新しいブランチが作成されます。

![](/images/git-beginner/how-to-create-branch.gif)

## ブランチを切り替える

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Checkout」を選択します。

![](/images/git-beginner/how-to-switch-branch.gif)

## ブランチを削除する

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Delete」を選択します。

![](/images/git-beginner/how-to-delete-branch.gif)

## ブランチ名を変更する

ブランチ一覧でベースとなるブランチを右クリックし、コンテキストメニューから「Rename..」を選択します。
ブランチ名を入力して「OK」を選択すると、ブランチ名が変更されます。

![](/images/git-beginner/how-to-rename-branch.gif)

## コミットメッセージを変更する（`F2`）

コミット一覧から変更対象のコミットを右クリックし、コンテキストメニューから「Edit Commit Message...」（`F2`）を選択します。
コミットメッセージを入力して、「OK」を選択すると、コミットメッセージが変更されます。

![](/images/git-beginner/how-to-edit-commit-message.gif)

## GitHubアカウントを設定する

Preferences（`⌘` + `,`） > Version Control > Github を選択し、「+」ボタンからお好みの方法でGithubアカウントをRubyMineに紐付けます。

![](/images/git-beginner/rubymine-210817-14:30:30.png)

※だいぶ前にGithubアカウントを連携したので、この先を詳細に覚えておらずすみません...。おそらく表示される内容の通りに作業をすれば問題なく登録できるかと思います。

## リモートリポジトリの設定

メニューバー Git > Manage Remotes...を選択します。

![](/images/git-beginner/rubymine-210817-14:36:01.png)

「+」ボタンを押して、登録するリモートリポジトリのエイリアス名とURLを登録します。

![](/images/git-beginner/rubymine-210817-14:38:09.png)

ここで登録したリモートリポジトリを、push、pull時に選択することが可能になります。
例えば、あるリポジトリをforkして自分のリポジトリにしている場合、fork元のリポジトリを「upstream」、forkしたリポジトリを「origin」とすることで、pullは「upstream」から、pushは「origin」を指定することが可能になります。

## push（`⌘` + `Shift` + `K`）

（`⌘` + `Shift` + `K`）を入力することで、Push画面を表示することができます。
画面左側にはPush先と対象のコミット一覧が、画面右側にはコミットごとのDiffが表示されています。

![](/images/git-beginner/how-to-push.gif)

Push先はクリックすることで変更でき、まだ登録されていないリモートリポジトリの場合は、この画面から登録することも可能です。

対象を確認後、「PUSH」を選択する（`⌘` + `Enter`）ことでPushを実行することができます。このとき、プルダウンから「Force Push」も選択可能です。

## fetch / pull / Update Project...（`⌘` + `T`）

いずれもリモートリポジトリの情報をローカルリポジトリに対して反映する方法です。

| 名前               | 概要                                                         | 操作方法                 |
| ------------------ | ------------------------------------------------------------ | ------------------------ |
| Fetch              | リモートブランチの情報を更新する。ローカルには反映しない     | メニューバー Git > Fetch |
| Pull               | 指定したリモートブランチの情報を更新し、ローカルに反映する。 | メニューバー Git > Pull  |
| Update Project | プロジェクト内のすべてのブランチに対して、Pullを実行する     | `⌘` + `T`               |

Pullは通常のPullコマンド同様に、ブランチやオプションを指定することができます。

![](/images/git-beginner/rubymine-210817-14:59:57.png)

Update Projectについても、取り込み時にマージするか、リベースするかを選択することができます。

![](/images/git-beginner/rubymine-210817-15:02:44.png)