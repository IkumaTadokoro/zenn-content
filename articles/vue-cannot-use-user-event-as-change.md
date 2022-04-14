---
title: "testing-library/user-eventではVueが期待するchangeイベントを発火できない"
emoji: "🤔" # アイキャッチとして使われる絵文字（1文字だけ）
type: "tech" # tech: 技術記事 / idea: アイデア記事
topics: ["vue"] # タグ。["markdown", "rust", "aws"]のように指定する
published: true # 公開設定（falseにすると下書き）
---

## 導入

### やりたかったこと

![](/images/vue-cannot-use-user-event-as-change/want_to.gif)

現在Vueを使って開発中のサービスの中で、フォームの値が確定したタイミング（つまり[change イベント](https://developer.mozilla.org/ja/docs/Web/API/HTMLElement/change_event)）でバリデーションを実行する処理を実装しています。
今回やりたかったのは、期待したタイミングで期待したメッセージが出るのかをテストすることです。

### testing-libraryとuserEvent

テストを記述していくにあたって、Vue Test UtilsとVue Testing Libraryの選択肢がありましたが、Kent C. Dodds氏が書いている[Testing Implementation Details](https://kentcdodds.com/blog/testing-implementation-details)を読んだことと、[Testing \| Vue\.js](https://vuejs.org/guide/scaling-up/testing.html#component-testing)でもTesting Libraryを推奨していることから、こちらを使用してテストを実装することに。

また[Testing LibraryのDoc](https://testing-library.com/docs/user-event/intro)を見ると、Testing Libraryの中からさらにユーザーの実際の振る舞いに合わせてラップした[testing\-library/user\-event](https://github.com/testing-library/user-event)があることを知り、これらを組み合わせてテストを書くことにしました。

### 問題点

以下のような形でテストを書き始めたものの、実際にテストを実行してみると正しくchangeイベントが発火せず、gifで表示されているようなエラーが表示されません。

```javascript
const input = getByLabelText('退職予定月を教えてください')

await user.type(input, '202201{enter}')
```

というわけでなんでうまくいかないのか調べました。

## 要約

- testing-library/user-eventはReactを想定して各イベントの発火処理をラップしている。
- ReactにおけるonChangeは、VueやネイティブHTMLのChangeイベントとは異なり、値の変更があったタイミングで発火されるイベントである。そのため、値が確定されたタイミングで発火されるVueのChangeイベントを再現することはできない。
- Vueにおいて、Changeイベントを再現するテストを記述する際には、[Vue Testing Library](https://github.com/testing-library/vue-testing-library)の`fireEvent.change()`を利用する。

## 原因

今回値の入力とイベントの発火を期待していた[`userEvent.type`](https://testing-library.com/docs/user-event/utility#type)は、次のような操作をラップしたAPIです。

1. 要素をクリックする
2. 引数で指定されたテキストを`userEvent.keyboard`（キーを1つずつ入力するAPI）を利用して入力する
3. 押されたキーを離す

一方で、Vueや今回私が期待しているChangeイベント、つまり[HTMLElement: change イベント \- Web API \| MDN](https://developer.mozilla.org/ja/docs/Web/API/HTMLElement/change_event)は、要素が確定したタイミングで発火します。これは一般的にinput要素からフォーカスが外れたタイミングです。

「そうなるとChangeイベントはどう発火するんだ」となりますが、そもそもReactにおけるonChangedは要素の値が変更されたタイミングで発火されるため、問題はありません。
userEventはReactをベースとして作成されたライブラリであるため、その他のフレームワークにおける操作は考慮されていません。

## 対応方法

### userEventを使用しない

そもそもuserEventはtesting-libraryの各種処理をユーザーが実際に操作する単位でラップしたもの（実装の詳細を意識しないでテストできるようにするもの）なので、
testing-libraryから直接イベントを発火する`fireEvent`を利用すれば、期待したchangeイベントを発火することができます。

```javascript
const input = getByLabelText('退職予定月を教えてください')

// userEventではchangeは発火できない
// await user.type(input, '202201{enter}')

// Vue Testing Library側の仕組みでchangeイベントを発火する
fireEvent.change(input, { target: { value: '202001' } })    
```

### 補足：VueにおいてuserEventを使用すべきか

テストの記述内容によってuserEventを使えたり使えなかったりする場合があることから認知的負荷を下げるため、無理にuserEventを使用せずVue Testing Libraryの機能を使用してテストを書くのがいいのではないかと思います（前述の通り、userEventはTestingLibraryをラップしたものであるため、userEventでできることはTestingLibraryの組み合わせで実現できる）。

Vue公式としても、推奨しているのはVue Testing Libraryの範囲までです。

> [We recommend using @testing\-library/vue for testing components in applications, as its focus aligns better with the testing priorities of applications\. Use @vue/test\-utils only if you are building advanced components that require testing Vue\-specific internals](https://vuejs.org/guide/scaling-up/testing.html#component-testing)

その点を踏まえても、Testing Libraryを使っていれば十分なのではと私は考えます。

## 歴史的経緯

この問題に出くわした当初、ざっとuserEventのIssueを検索したら、「もともとReactを想定していたけど、Vueにも合わせるよ」的なIssueを見つけたので、
「あれ、やっぱり問題ないのかな」と思ったのですが、その後Issueには載っていない部分で色々あったため、経緯もまとめてみました。

### Testing Libraryの原点と位置付け

[Testing Library](https://github.com/testing-library)には現在複数のリポジトリがありますが、原点としてはReactのためのライブラリのようです。

[Testing Implementation Details](https://kentcdodds.com/blog/testing-implementation-details)を書いているKent C. Dodds氏がreact-testing-libraryの作者で、記事の通り「Reactにおいて、実装の詳細を意識しないでテストできるようにする」「ユーザーが実際に操作するように振る舞いをテストする」ことを目的としてライブラリが作成されました。

後発として他のフレームワーク向けに用意されたTesting Libraryが開発されます。[Vue Testing Library](https://github.com/testing-library/vue-testing-library)もその一つです。
各ライブラリのコアとなる部分は[DOM Testing Library](https://github.com/testing-library/dom-testing-library)としてリポジトリが分かれています。

### userEventの原点と位置付け

Testing Libraryの目的にある「ユーザーが実際に操作するように振る舞いをテストする」という観点から、ユーザーが実際に行う操作単位でTesting Libraryの一部の操作をラップした「[userEvent](https://github.com/testing-library/user-event)」が作成されました。こちらも当初はReact向けに作成されたものでした。

DOM Testing Libraryのドキュメントのeventについての説明には以下のように書かれていて、ユーザーが実際にイベントを発火するような操作については、userEventを利用するよう推奨されています。

> Most projects have a few use cases for fireEvent, but the majority of the time you should probably use @testing-library/user-event.　[Firing Events \| Testing Library](https://testing-library.com/docs/dom-testing-library/api-events)

### Vue、Preact、HTML vs ReactにおけるChangeイベントにおける議論

https://github.com/testing-library/user-event/issues/119

2019年に一度、「Vue Testing Libraryにおいては、`userEvent.type`が期待されるように動作しない。」というIssueがあがりました（補足ですが、Issueを立てたAdrià Fontcuberta氏はVue Testing Libraryのメンテナで、Giorgio Polvara氏はuserEventの作者です）。

この中で、「ReactのonChangeイベントと、VueやPreactなどのHTMLのchangeイベントが異なるという話になり、実際に

- Vue向けの対応の一環として、Vueにおけるテストを追加する

https://github.com/testing-library/user-event/pull/145

- VueなどのネイティブHTMLのchangeを期待するフレームワーク向けに、`userEvent.type`の最後にchangeイベントを発火する処理を追加する

https://github.com/testing-library/user-event/pull/147

という修正が実施されました。これが2019年7月くらいです。

### Testing Libraryの改修（v14.0）

しかしながら、翌2020年の5月にここまでの修正がすべて無と化しました。

https://github.com/testing-library/userEvent/pull/290

どういう経緯があったのかはわかりませんが、Testing Libraryの生みの親であるKent C. Dodds氏が一括で修正を行い、その結果Vue用に別に用意されたテストファイルや、`userEvent.type`の最後に追加されていたイベントも削除されました。

これにより現在に至るまで、`userEvent.type`はReactを想定した実装になっているため、Vueでは意図したようにChangeイベントを発火できなくなっています。

## おわりに

Kent C. Dodds氏の記事に始まり、彼のPRに終わるというなんとも言えない結果になりましたが、フロントエンドのテスト周りはミリしら状態であったため、 今回の調査を通じて、各ライブラリの位置付けがわかってよかったです。

---

自身が調べた限りでは記事の通りだと思ったのですが、上述のとおりフロントエンドのテストについて見識が深くないため、マサカリ大歓迎です。
