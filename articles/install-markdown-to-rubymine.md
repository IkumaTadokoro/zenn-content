---
title: "RubyMineにESLintを導入する" # 記事のタイトル
emoji: "👮‍♀️" # アイキャッチとして使われる絵文字（1文字だけ）
type: "tech" # tech: 技術記事 / idea: アイデア記事
topics: ["rubymine", "eslint"] # タグ。["markdown", "rust", "aws"]のように指定する
published: true # 公開設定（falseにすると下書き）
---

## はじめに

ESLintをRubyMineにインストールする方法は公式ガイドに記載がありますが、最新のガイドに則って実行している記事がなかったため、 自環境でインストールしてみました。
RubyMineでJSを書く方の参考になれば幸いです。

## 前提

- RubyMineのバージョンは2021.2
- Node.jsがインストールされていること
- npmが使えること

## TL:DR;

- RubyMineは初期状態ではESLintが無効。ただし標準でESLintをサポートしている。
- ESLintを有効にすると、エディタ上で指摘箇所が表示され、指摘箇所単位、ファイル単位でFIXすることが可能
- ファイルを保存した際に自動でESLintを適用する設定も可能

## 既存の作業ディレクトリに対して、ESLintを有効にする

### 手順

以下の手順で進めます。

1. Node.jsの設定
2. ESLintのインストール
3. ESLintの定義ファイルの作成
4. ESLintの有効化

### 1. Node.jsの設定

Preferences（`⌘` + `,`） > Languages & Frameworks > Node.js and NPM を開き、「Node interpreter」に使用するNode.jsのバージョンを指定します。

![](/images/install-markdown-to-rubymine/rubymine-210816-17:06:29.png)

### 2. ESLintのインストール

[Getting Started with ESLint \- ESLint \- Pluggable JavaScript linter](https://eslint.org/docs/user-guide/getting-started)に則って、ESLintをインストールします。

```bash
% cd 作業ディレクトリ
% npm install eslint --save-dev
```

### 3. ESLintの定義ファイルの作成

[Getting Started with ESLint \- ESLint \- Pluggable JavaScript linter](https://eslint.org/docs/user-guide/getting-started)に則って、ESLintの定義ファイルを作成します。

```bash
% cd 作業ディレクトリ
% npx npx eslint --init

# 対話形式でファイルが作成される。自分の作業する内容に応じて、チェック内容を適宜選択すること
? How would you like to use ESLint?
  To check syntax only 
  To check syntax and find problems 
> To check syntax, find problems, and enforce code style

? What type of modules does your project use? (Use arrow keys)
  JavaScript modules (import/export)
  CommonJS (require/exports)
> None of these

? Which framework does your project use?
  React
  Vue.js
> None of these

? Does your project use TypeScript? 
❯ No 
  Yes

? Where does your code run? 
  browser
❯ node

? How would you like to define a style for your project?
❯ Use a popular style guide
  Answer questions about your style
  Inspect your JavaScript file(s)

? Which style guide do you want to follow?
  Airbnb: https://github.com/airbnb/javascript
> Standard: https://github.com/standard/standard
  Google: https://github.com/google/eslint-config-google

# RubyMineは作業ディレクトリに保存されている`.eslintrc.*`ファイルを定義ファイルとして使用します。
# そのため、定義ファイルの形式はいずれでも構いません。
? What format do you want your config file to be in?
   JavaScript
>  YAML
   JSON
```

### 4. ESLintの有効化

Preferences（`⌘` + `,`） > Languages & Frameworks > JavaScript > Code Quality Tools > ESLint  を開きます。

![](/images/install-markdown-to-rubymine/rubymine-210816-17:16:29.png)

初期値では「Disable」がチェックされていますが、これを「Automatic ESLint Configuration」に変更します。
またファイル保存（`⌘` + `S`）時に自動で修正を実行するには、「Run eslint --fix on save」にチェックを入れます。

---

以上でESLintのインストールは終了です。以降は手順3で作成した`.eslintrc.*`をもとに、コードのチェックが入ります。
（定義ファイルを修正した場合は、その内容でチェックが行われます）

RubyMineのコンテキストアクション（指摘箇所に波線が出るので、`⌥` + `Enter`）で修正が可能になります。

## すべての新規ファイルに対して、ESLintを有効にする

手順4の設定については、プロジェクトごとではなく、RubyMineで開くすべてのプロジェクトに対して適用することも可能です。

1. ナビゲーションバーの File > New Projects Setup > Preferences for New Projects...を開きます。

![](/images/install-markdown-to-rubymine/rubymine-210816-17:25:55.png)

2. Languages & Frameworks > JavaScript > Code Quality Tools > ESLint 開きます。

![](/images/install-markdown-to-rubymine/rubymine-210816-17:26:05.png)

3. 先程の手順4同様に設定します。

## JavaScript標準スタイルを適用する

余談ではありますが、ESLintの適用以前にエディタの設定として、JavaScript標準スタイルを適用することができます。

1. Preferences（`⌘` + `,`） > Editor > Code Style > JavaScript を開きます

![](/images/install-markdown-to-rubymine/rubymine-210816-17:32:57.png)

2. 「Set from...」を選択し、「JavaScript Standard Style」を選択して、「APPLY」「OK」を選択します。

![](/images/install-markdown-to-rubymine/rubymine-210816-17:34:29.png)

もちろんこの設定についても、プロジェクト単位でも、すべてのプロジェクト単位でも設定可能です。

## 参考

- [ESLint \| RubyMine](https://pleiades.io/help/ruby/eslint.html) 
