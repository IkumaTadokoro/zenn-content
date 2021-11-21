---
title: "【Rails】リクエストのフォーマットに`JS`を指定したら、Railsは何をレスポンスとして返すのか" # 記事のタイトル
emoji: 🤔" # アイキャッチとして使われる絵文字（1文字だけ）
type: "tech" # tech: 技術記事 / idea: アイデア記事
topics: ["rails", "ruby"] # タグ。["markdown", "rust", "aws"]のように指定する
published: false # 公開設定（falseにすると下書き）
---

この記事は「[フィヨルドブートキャンプ Part 1 Advent Calendar 2021](https://adventar.org/calendars/6331)」の3日目の記事です。 
Part2もあります→「[フィヨルドブートキャンプ Part 2 Advent Calendar 2021](https://adventar.org/calendars/6360)」

Part1、昨日の記事はken_c_loさんの「」、Part2、昨日の記事は「aaa」さんの「」でした!
明日の担当はima1zumiさんとYuki Watanabeさんです。

## 問題

### どんなリクエストがかえってくると思いますか？

### ログをみてみる

- application.html.erb
  - スタイルシートのエントリポイント

## 環境

Rails 6.1.4.1

## TL:DR;

- SJRの中でHTMLのパーシャルを描画するために、フォーマットにJSが指定された場合は、JSとHTMLのビューを探索する
- SJRを利用していない場合は、対応するアクションに紐づくHTMLのテンプレートが採用される
- 上記挙動はあくまでアクションに紐づくテンプレートの話であり、application.html.erbは`JS`として探索されるため、中途半端なレンダリングになる

## そもそもRailsはどのようにVIEWをレンダリングしているのか

- MVCのおさらい
- 暗黙の`render`
- LookupContext

## なぜJavaScriptを指定した際に、HTMLもテンプレートの探索条件になるのか

- SJR
  - 概要
  - 挙動
- 

## この仕様に対する動向

## まとめ

## おわりに

- この問題を考えるきっかけ
- RailsってPRない時代とかあったんですね
- 伊藤さんへの感謝とフィヨルドブートキャンプのコミュニティ
- RubyMine入門の宣伝
