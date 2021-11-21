---
title: "Rails6にTailwindCSSを導入し、tailwind.config.jsでカスタマイズもできるようにする" # 記事のタイトル
emoji: "🎐" # アイキャッチとして使われる絵文字（1文字だけ）
type: "tech" # tech: 技術記事 / idea: アイデア記事
topics: ["rails", "ruby", "tailwind", "webpack", "JavaScript"] # タグ。["markdown", "rust", "aws"]のように指定する
published: true # 公開設定（falseにすると下書き）
---

## きっかけ

TailwindCSSを使ってみようと思って、[Tailwind Play](https://play.tailwindcss.com/)で練習を積み、「よしRailsでやるか！」と意気込んでいたのですが、環境構築でボロボロに...。

出回っている導入方法は、以下2つがあったのですが、

1. yarnでTailwindCSSをインストールする
2. [rails/tailwindcss\-rails](https://github.com/rails/tailwindcss-rails)を使って、gemで導入する

1はTailwindとPostCSSとWebpackの依存性がややこしくて、最後まで辿り着かず、2の方はお手軽ながらも`tailwind.config.js`の内容がなぜか反映できず、
カスタマイズができなくて辛い...ということで、新たに導入記事を書くことにしました。


## 環境

- Rails: 6.1.4.1
- TailwindCSS: 2

## リポジトリ

今回の記事で扱った内容は、以下のリポジトリで確認できます。

https://github.com/IkumaTadokoro/rails6-and-tailswind-sample

## アプリケーション作成

まずはサンプルアプリケーションを作成します。

```bash
$ mkdir rails6-and-tailwind-sample
$ cd rails6-and-tailwind-sample
$ rails new .
$ rails db:create #sqlite3で試す場合は不要
$ bin/rails s
```

![](/images/install-tailwind-in-rails6-with-webpacker/rails-new.png)

## 必要なパッケージのインストール

TailwindCSSの2系は、PostCSSの8系に依存しています。そのため、必要なパッケージをバージョン指定で一括で追加します。

```bash
$ yarn add tailwindcss@2 postcss@8 @fullhuman/postcss-purgecss@4 postcss-loader@4 autoprefixer@10
```

| パッケージ       | 概要                                | 参考 |
| ---------------- | ----------------------------------- | ---- |
| tailwindcss      | 言わずもがな、今回の主眼。2系です。 | [Tailwind CSS \- Rapidly build modern websites without ever leaving your HTML\.](https://tailwindcss.com/) |
| postcss          | CSSをJavascriptでごにょごにょしてくれるやつです | [PostCSS まとめ \- Qiita](https://qiita.com/morishitter/items/4a04eb144abf49f41d7d) |
| postcss-purgecss | フレームワークを利用することで肥大化するCSSのうち、実際に使うCSSのみを抽出することで動作を軽くしてくれるプラグインです | [PurgeCSS \- Remove unused CSS](https://purgecss.com/)|
| postcss-loader   | CSSをJavaScriptのコードとして扱わせるCSS loaderのPostCSS版 | [webpack\-contrib/postcss\-loader: PostCSS loader for webpack](https://github.com/webpack-contrib/postcss-loader)|
| autoprefixer     | ベンダープリフィクスなど、ブラウザに合わせた設定が追加されたCSSを生成してくれます | [PostCSS まとめ \- Qiita](https://qiita.com/morishitter/items/4a04eb144abf49f41d7d#autoprefixer)|

## TailwindCSSの読み込み

TailwindCSSを読み込むために、CSSファイルを作成します。

```bash
$ mkdir app/javascript/stylesheets
$ touch app/javascript/stylesheets/application.css
```

```css:application.css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

作成したCSSを読み込ませるために、`application.js`に`import`を追加します。

```js:application.js
# 略
import "channels"
import "stylesheets/application.css" # ADD

Rails.start()
# 略
```

PostCSSにTailWindCSSを読み込ませるために`require`を追加します。

```js:postcss.config.js
module.exports = {
  plugins: [
    require('tailwindcss'),
    require('postcss-import'),
    # 略
```

最後に`stylesheet_pack_tag`を`application.html.erb`に追加します。

```erb:application.html.erb
<!DOCTYPE html>
<html>
  <head>
    # 略

    <%= stylesheet_pack_tag 'application', 'data-turbolinks-track': 'reload' %> # 追加
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>
```

## TailwindCSSのconfigを追加

以下のコマンドでディレクトリ直下に`tailwind.config.js`が作成されます。

```bash
$ npx tailwindcss init
```

```js:tailwind.config.js
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
```

JITモードとpurgeオプションを追加します。

```js:tailwind.config.js
module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  # 略
```

purgeは先の通り、必要なCSSだけを読みにいき、ビルドサイズを削減するオプションです。
JITはTailwindCSSのJustInTimeモードを有効にするオプションで、ざっくりいうと「早い」モードです。
TailwindCSSの公式プレイグラウンドである[Tailwind Play](https://play.tailwindcss.com/)でも有効になっているので、ONにしておけば良いと思います（あんまりよくわかってない）。

## 動作確認

何だかいけそうな感じなので、ここらで動作確認をしてみたいと思います。

```bash
$ rails g controller home index
```

```erb:index.html.erb
<h1 class="text-red-500 text-9xl">Home#index</h1> # TailwindCSSのクラスを適用する（でかくて赤い文字）
<p>Find me in app/views/home/index.html.erb</p>
```

```bash
$ bin/webpack-dev-server
ERROR in ./app/javascript/stylesheets/application.css (./node_modules/css-loader/dist/cjs.js??ref--5-1!./node_modules/postcss-loader/dist/cjs.js??ref--5-2!./app/javascript/stylesheets/application.css)
Module build failed (from ./node_modules/postcss-loader/dist/cjs.js):
ValidationError: Invalid options object. PostCSS Loader has been initialized using an options object that does not match the API schema.
 - options has an unknown property 'config'. These properties are valid:
   object { postcssOptions?, execute?, sourceMap?, implementation? }
    at validate (/Users/tadokoroikuma/RubymineProjects/sandbox/rails6-and-tailwind-sample/node_modules/postcss-loader/node_modules/schema-utils/dist/validate.js:105:11)
    at Object.loader (/Users/tadokoroikuma/RubymineProjects/sandbox/rails6-and-tailwind-sample/node_modules/postcss-loader/dist/index.js:43:29)
ℹ ｢wdm｣: Failed to compile.
```

あれ、エラーになってしまいました。

## postcss-loaderのエラーを解消

このエラーはどうもpostcss-loaderのoptionの形式が変わったことが原因であるようです。
同じ内容のissueがrails/web-packerのリポジトリに上がっていました。

https://github.com/rails/webpacker/issues/2784

Conversationsを追っていくと、どうもwebpackerのenvironment.jsにスクリプト的なものを書くことで回避できるようです。
というわけで、下記を`config/webpack/environment.js`に追記します。

```js:environment.js
function hotfixPostcssLoaderConfig (subloader) {
  const subloaderName = subloader.loader
  if (subloaderName === 'postcss-loader') {
    if (subloader.options.postcssOptions) {
      console.log(
        '\x1b[31m%s\x1b[0m',
        'Remove postcssOptions workaround in config/webpack/environment.js'
      )
    } else {
      subloader.options.postcssOptions = subloader.options.config;
      delete subloader.options.config;
    }
  }
}

environment.loaders.keys().forEach(loaderName => {
  const loader = environment.loaders.get(loaderName);
  loader.use.forEach(hotfixPostcssLoaderConfig);
});
```

## 動作確認2

```bash
$ bin/webpack-dev-server
$ bin/rails s
```

http://localhost:3000/home/index にアクセスすると...

![](/images/install-tailwind-in-rails6-with-webpacker/demo1.png)

期待通り、TailwindCSSが適用された状態でVIEWが表示されました！！

## tailwind.config.jsでカスタマイズしてみる

デフォルトのTailwindCSSが適用されることを確認できたので、次はtailwind.config.jsを修正して、スタイルをカスタマイズできるか試します。
今回は試しにカスタムの色を作成して、それが適用できるかをチェックします。

まずはVIEWファイルに`text-accent`という今回追加する色のクラスを追加します。

```erb:index.html.erb
<h1 class="text-accent text-9xl">Home#index</h1>
<p>Find me in app/views/home/index.html.erb</p>
```

この状態で確認すると、まだカスタマイズ設定が適用されていないので、スタイルが適用されていない状態になります。

![](/images/install-tailwind-in-rails6-with-webpacker/demo2.png)

それでは、`tailwind.config.js`を開き、カスタマイズを追記しましょう。

```js:tailwind.config.js
# 略
  theme: {
    extend: {
      // 色の設定を拡張
      colors: {
        accent: '#FFB600',
      }
    },
  },
# 略
```

![](/images/install-tailwind-in-rails6-with-webpacker/demo3.png)

カスタマイズ内容が適用されたVIEWが表示されました🎉

## 終わりに

調べている途中で、Rails 7でのフロントエンド周りについて、DHHが解説している動画に出会いました。

https://www.youtube.com/watch?v=JsNtLiph87Y

Rails7からは`rails new`する際に、`--css tailwind`とするだけでTailwindCSSが導入できるそうです。これは便利ですね！

というわけで、Rails6系は7系に置き換わり、需要は少なくなると思いますが、この記事がどなたかの役に立てば幸いです😄
