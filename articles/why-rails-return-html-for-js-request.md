---
title: "【Rails】RailsはリクエストのフォーマットにJavaScriptを指定しても、HTMLを返すことがある"
emoji: "🤔" # アイキャッチとして使われる絵文字（1文字だけ）
type: "tech" # tech: 技術記事 / idea: アイデア記事
topics: ["rails", "ruby"] # タグ。["markdown", "rust", "aws"]のように指定する
published: false # 公開設定（falseにすると下書き）
---

この記事は「[フィヨルドブートキャンプ Part 1 Advent Calendar 2021](https://adventar.org/calendars/6331)」の3日目の記事です。

https://adventar.org/calendars/6331

Part2もあります→「[フィヨルドブートキャンプ Part 2 Advent Calendar 2021](https://adventar.org/calendars/6360)」

https://adventar.org/calendars/6360

Part1、昨日の記事はken_c_loさんの「」、Part2、昨日の記事は「aaa」さんの「」でした!

## 概要

現在私はFJORD BOOT CAMPというプログラミングスクールに参加して、チーム開発を経験しています。  
今回の記事では、その中で遭遇したバグをきっかけに、Railsのビューレンダリングについての仕様を調査した結果について解説しようと思います。

- 解説すること：
  - リクエストのフォーマットにJavaScriptを含めた場合のRailsのビューレンダリングの挙動
  - リクエストのフォーマットにかかわらず、特定の形式のファイルを返す方法
- 環境：Rails 6.1.4.1

## TL:DR;

- SJRの中でHTMLのパーシャルを描画するために、フォーマットにjsが指定された場合は、JavaScriptとHTMLのビューを探索する
- SJRを利用していない場合は、対応するアクションに紐づくHTMLのテンプレートが採用される
- 上記挙動はあくまでアクションに紐づくテンプレートの話であり、application.html.erbは`js`のみで探索されるため適用されない（=CSS等が適用されない）
- `resources ... format: "html"`と書くことで、HTML固定でレスポンスを返すことができる

---

## 問題

突然ですが、ここに簡単なログイン画面を実装したRailsアプリがあります。

![](/images/why-rails-return-html-for-js-request/index-html-normal.png)

```ruby:routes.rb
Rails.application.routes.draw do
  get 'home/index'
end
```

```ruby:home_controller.rb
class HomeController < ApplicationController
  def index
  end
end
```

:::details app/views/home/index.html.erb

```erb
<!-- CSSはTailwindCSSを利用 -->
<body class="font-mono bg-gray-400">
<!-- Container -->
<div class="container mx-auto">
  <div class="flex justify-center px-6 my-12">
    <!-- Row -->
    <div class="w-full xl:w-3/4 lg:w-11/12 flex">
      <!-- Col -->
      <div
        class="w-full h-auto bg-gray-400 hidden lg:block lg:w-5/12 bg-cover rounded-l-lg"
        style="background-image: url('https://source.unsplash.com/Mv9hjnEUHR4/600x800')"
      ></div>
      <!-- Col -->
      <div class="w-full lg:w-7/12 bg-white p-5 rounded-lg lg:rounded-l-none">
        <h3 class="pt-4 text-2xl text-center">Create an Account!</h3>
        <form class="px-8 pt-6 pb-8 mb-4 bg-white rounded">
          <div class="mb-4 md:flex md:justify-between">
            <div class="mb-4 md:mr-2 md:mb-0">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="firstName">
                First Name
              </label>
              <input
                class="w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline"
                id="firstName"
                type="text"
                placeholder="First Name"
                />
            </div>
            <div class="md:ml-2">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="lastName">
                Last Name
              </label>
              <input
                class="w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline"
                id="lastName"
                type="text"
                placeholder="Last Name"
                />
            </div>
          </div>
          <div class="mb-4">
            <label class="block mb-2 text-sm font-bold text-gray-700" for="email">
              Email
            </label>
            <input
              class="w-full px-3 py-2 mb-3 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline"
              id="email"
              type="email"
              placeholder="Email"
              />
          </div>
          <div class="mb-4 md:flex md:justify-between">
            <div class="mb-4 md:mr-2 md:mb-0">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="password">
                Password
              </label>
              <input
                class="w-full px-3 py-2 mb-3 text-sm leading-tight text-gray-700 border border-red-500 rounded shadow appearance-none focus:outline-none focus:shadow-outline"
                id="password"
                type="password"
                placeholder="******************"
                />
              <p class="text-xs italic text-red-500">Please choose a password.</p>
            </div>
            <div class="md:ml-2">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="c_password">
                Confirm Password
              </label>
              <input
                class="w-full px-3 py-2 mb-3 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline"
                id="c_password"
                type="password"
                placeholder="******************"
                />
            </div>
          </div>
          <div class="mb-6 text-center">
            <button
              class="w-full px-4 py-2 font-bold text-white bg-blue-500 rounded-full hover:bg-blue-700 focus:outline-none focus:shadow-outline"
              type="button"
            >
              Register Account
            </button>
          </div>
          <hr class="mb-6 border-t" />
          <div class="text-center">
            <a
              class="inline-block text-sm text-blue-500 align-baseline hover:text-blue-800"
              href="#"
            >
              Forgot Password?
            </a>
          </div>
          <div class="text-center">
            <a class="inline-block text-sm text-blue-500 align-baseline hover:text-blue-800" href="#">
              Already have an account? Login!
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
```

:::

`http://0.0.0.0:3000/home/index`にアクセスすることで`home/index.html.erb`が表示されます。

### リクエストに拡張子を指定すると、その拡張子のファイルを返す

さて先の通り、`http://0.0.0.0:3000/home/index`にアクセスした場合は、`home/index.html.erb`（HTML）が表示されます。

この場合はリクエストの中でformatを設定していないため、デフォルトのフォーマットであるHTMLのファイルが描画されますが、`http://0.0.0.0:3000/home/index.xml`のように拡張子を指定してリクエストを投げると、そのformatに応じたレスポンスを返すことができます。

なお、指定されたformatに合致するファイルが存在しない場合は、`ActionController::UnknownFormat`が発生します。

### どんなレスポンスがかえってくると思いますか？

では次のように拡張子を指定してアクセスした場合は、どんなレスポンスが返ってくるでしょうか？
ただし、jsやjsonといった拡張子のファイルは用意しておらず、先程の`index.html.erb`のみが作成されているものとします。

1. `http://0.0.0.0:3000/home/index.html`
2. `http://0.0.0.0:3000/home/index.json`
3. `http://0.0.0.0:3000/home/index.js`

---

それぞれの（開発環境における）表示は次のようになります。

1. `http://0.0.0.0:3000/home/index.html`

![](/images/why-rails-return-html-for-js-request/index-html-html.png)


2. `http://0.0.0.0:3000/home/index.json`

![](/images/why-rails-return-html-for-js-request/index-html-json.png)

3. `http://0.0.0.0:3000/home/index.js`

![](/images/why-rails-return-html-for-js-request/index-html-js.png)

---

1は拡張子を省略したケースと同様にHTMLを返しています。 
2はJSON形式のフォーマットが存在していないため、`ActionController::UnknownFormat`が発生しています。
では3はどういうことでしょうか？

JSについてもフォーマットが存在しないため、`ActionController::UnknownFormat`が発生すると想像しましたが、なんだか中途半端に表示されています（CSSが適用されていない...?）

## どういう事象なのか？

### ログを確認してみる

まずはどういう状況になっているのか、それぞれのケースのログを確認してみます。

```log:development.log(index.html)
Started GET "/home/index.html" for 127.0.0.1 at 2021-11-30 16:08:16 +0900
Processing by HomeController#index as HTML
  Rendering layout layouts/application.html.erb
  Rendering home/index.html.erb within layouts/application
  Rendered home/index.html.erb within layouts/application (Duration: 2.1ms | Allocations: 216)
  Rendered layout layouts/application.html.erb (Duration: 17.1ms | Allocations: 2828)
Completed 200 OK in 31ms (Views: 24.8ms | Allocations: 4028)
```

```log:development.log(index.json)
Started GET "/home/index.json" for 127.0.0.1 at 2021-11-30 16:09:47 +0900
Processing by HomeController#index as JSON
Completed 406 Not Acceptable in 2ms (Allocations: 1297)

ActionController::UnknownFormat (HomeController#index is missing a template for this request format and variant.

request.formats: ["application/json"]
request.variant: []):
  
actionpack (6.1.4.1) lib/action_controller/metal/implicit_render.rb:42:in `default_render'
# 以下略
```

```log:development.log(index.js)
Started GET "/home/index.js" for 127.0.0.1 at 2021-11-30 16:10:35 +0900
Processing by HomeController#index as JS
  Rendering home/index.html.erb
  Rendered home/index.html.erb (Duration: 0.1ms | Allocations: 38)
Completed 200 OK in 6ms (Views: 3.7ms | Allocations: 1409)
```

各ログの2行目に注目してみると、`Processing by HomeController#index as HTML`のように、リクエストで指定した拡張子で処理を行おうとしているように見えます。 ここは期待通りのようです。

JSONの場合は例外が発生しているので、HTMLとJSのその後を比較してみます。

```log
<index.html>
  Rendering layout layouts/application.html.erb
  Rendering home/index.html.erb within layouts/application
  Rendered home/index.html.erb within layouts/application (Duration: 2.1ms | Allocations: 216)
  Rendered layout layouts/application.html.erb (Duration: 17.1ms | Allocations: 2828)

<index.js>
  Rendering home/index.html.erb
  Rendered home/index.html.erb (Duration: 0.1ms | Allocations: 38)
```

この結果から、

- いずれの場合も、`home/index.html`が描画されている
- `js`をフォーマットに指定した場合は、`layouts/layouts/application.html.erb`が描画されていない

ということがわかりました。

### application.htmlが読み込まれていない = stylesheetが読み込まれていない

`application.html.erb`にはスタイルシートのエントリーポイントが設定されているため、これが読み込まれなかったことでCSSが適用されていない、素の`index.html.erb`が表示されたようです。

:::details application.html.erb

```erb:application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <title>Rails6AndTailwindSample</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

:::

![](/images/why-rails-return-html-for-js-request/index-html-js.png)

つまり「Railsでリクエストのフォーマットに`js`を指定したら、Railsは何をレスポンスとして返すのか」という問いに対する答えは、 「指定したコントローラーのアクションに紐づくVIEWファイルのみを表示する」ということになります。

事象は理解できましたが、では「`js`を指定しているのにもかかわらず、どうやってHTMLが表示される」のでしょうか。

この原因を探るために、今度はRailsのレンダリングの仕組みを追ってみます。

### ここまでのまとめ

- Railsでリクエストのフォーマットに`js`を指定したら、Railsは「指定したコントローラーのアクションに紐づくHTMLファイルのみを表示する」
- CSSやJavaScriptのエントリーポイントである`application.html.erb`が描画されないため、CSSやJavaScriptが適用されていない、素のHTMLが表示されているように見える

## どうやって`js`を指定してもHTMLを表示しているのか？

### MVCのおさらい

いきなりRailsのソースを眺めるのは少し飛躍がありますので、まずは基本的なMVCの仕組みから確認していきましょう。

![](/images/why-rails-return-html-for-js-request/mvc.png)

大まかなRailsのリクエスト処理の流れは次の通りです。
1. HTTPリクエストがあると、routesに則って適切なコントローラーのアクションに振り分けられる
2. コントローラーのアクションは`コントローラー/アクション`となる名前のVIEWを検索し、ユーザーにレスポンスを返す

上記1、2をソース単位で追ってみます。

```ruby:routes.rb
Rails.application.routes.draw do
  get 'home/index'
end
```

1）リクエストと呼び出し先のアクション名が同じなので一部省略されていますが、`home/index`がリクエストされた場合は`HomeController#index`を呼び出すように指定されています。

```ruby:HomeController
class HomeController < ApplicationController
  def index
  end
end
```

2）続いて`HomeController#index`ですが、特に何も処理は書かれていません。次はここを深掘りしていく必要がありそうです。

### 暗黙の`render`

自前で実装したControllerの処理が完了すると、`ActionController::BasicImplicitRender`に処理が移ります。

```ruby:basic_implicit_render.rb
module ActionController
  module BasicImplicitRender # :nodoc:
    def send_action(method, *args)
      super.tap { default_render unless performed? }
    end

    def default_render
      head :no_content
    end
  end
end
```

https://github.com/rails/rails/blob/main/actionpack/lib/action_controller/metal/basic_implicit_render.rb#L6

`super.tap { default_render unless performed? }`の部分は、実装したController内で明示的に`render`が実行されている（=`performed?`）のであれば、`default_render`を呼び出す仕組みです。

先ほど確認した通り、Controllerには何も処理がありませんので、`default_render`が実行されることになります。

`default_render`の実装自体は`ActionController::ImplicitRender`で実装されています。

```ruby:implicit_render.rb
module ActionController
  module ImplicitRender
    include BasicImplicitRender

    def default_render
      if template_exists?(action_name.to_s, _prefixes, variants: request.variant)
        render
      elsif any_templates?(action_name.to_s, _prefixes)
        message = "#{self.class.name}\##{action_name} is missing a template " \
          "for this request format and variant.\n" \
          "\nrequest.formats: #{request.formats.map(&:to_s).inspect}" \
          "\nrequest.variant: #{request.variant.inspect}"

        raise ActionController::UnknownFormat, message
      elsif interactive_browser_request?
        message = "#{self.class.name}\##{action_name} is missing a template for request formats: #{request.formats.map(&:to_s).join(',')}"
        raise ActionController::MissingExactTemplate, message
      else
        logger.info "No template found for #{self.class.name}\##{action_name}, rendering head :no_content" if logger
        super
      end
    end
    
    # 略
  end
end
```

https://github.com/rails/rails/blob/main/actionpack/lib/action_controller/metal/implicit_render.rb

いろいろと書いてありますが、概要を抜粋すると以下のような感じです。

```ruby
def default_render
  if template_exists?(action_name.to_s, _prefixes, variants: request.variant)
    render
  elsif any_templates?(action_name.to_s, _prefixes)
    # 略
    raise ActionController::UnknownFormat
    # 略
  end
end
```

ブラウザに描画された内容と照らし合わせると、`html`と`js`をフォーマットに指定した場合は最初の分岐に、`json`を指定した場合は2つ目の分岐に入っているようです。

続いて、条件となっている`template_exists`の処理を追います。

```ruby
def default_render
  if template_exists?(action_name.to_s, _prefixes, variants: request.variant)
```

`action_name.to_s`には今回の場合だと`index`が、`_prefixes`には`%w[home application]`が格納されています。

つまり、呼び出しているアクションとコントローラー（継承元含む）が設定されているわけです。
Railsはこれらの値を使ってVIEWテンプレートを探しにいきます。

`template_exists`メソッド自体は`view_path.rb`でdelegateされているもので、実際の定義は`lookup_context`と呼ばれる、VIEW探索のための情報を格納するクラスにあります。

```ruby:lookup_context.rb
def exists?(name, prefixes = [], partial = false, keys = [], **options)
  @view_paths.exists?(*args_for_lookup(name, prefixes, partial, keys, options))
end
alias :template_exists? :exists?
```

https://github.com/rails/rails/blob/main/actionview/lib/action_view/lookup_context.rb#L137

`@view_paths`はVIEWファイルが格納されているディレクトリの配列で、`app/views`をはじめとして、各Gemの中で定義しているVIEWファイルのパス（例：`actionmailbox/app/views`、`devise/app/views`）を配列として保持しています。

大枠の流れとしては、`@view_paths`のディレクトリを`index`、`_prefixes`の名前を使って、VIEWテンプレートを探しにいくというような流れになります。

### formatの指定

さて、VIEWテンプレートの検索の際に色々なオプションが指定されるのですが、その一つが`format`です。
基本的にはリクエストにのってきた拡張子だけが`format`として設定されますが、`js`の場合だけは分岐処理が入っています。

```ruby:lookup_context.rb
# Override formats= to expand ["*/*"] values and automatically
# add :html as fallback to :js.
def formats=(values)
  if values
    # 略
    if values == [:js]
      values << :html
      @html_fallback_for_js = true
    end
  end
  super(values)
end
```

https://github.com/rails/rails/blob/main/actionview/lib/action_view/lookup_context.rb#L245

ソースの通りですが、リクエストにのってきた拡張子が`js`の場合、`html`も`format`とするような分岐が入っています。
そのため、`format`に`js`を指定した場合は、`js`もしくは`html`のファイルを探索しにいき、VIEWをレンダリングするというような挙動になります。

### ここまでのまとめ

- RailsはControllerで`render`が定義されていない場合、対応するVIEWテンプレートを暗黙的に`render`する
- 対応するVIEWテンプレートは以下の条件で探索される
  - 探索場所：`@view_paths`（`app/view`や各Gemで作成されている`app/{GEM_NAME}/）
  - ファイル格納場所：実行中のコントローラーの名称と同じ
  - ファイル名：実行中のアクションの名称と同じ
  - 形式：リクエストに指定したフォーマット（デフォルト:`html`）。ただし、リクエストが`js`の場合のみ、`js`と`html`

## なぜJavaScriptを指定した際に、HTMLもテンプレートの探索条件になるのか？

ここまでどうやってこのような挙動になるかをみてきました。ではなぜRailsはこのような仕様になっているのでしょうか。
それはSJRを利用した際に、js.erbファイル内で定義しているHTMLのパーシャルをformat指定なしでレンダリングできるようにするためです。

### SJRとは

SJRとはServer-generated JavaScript Responsesの略で、その名の通りサーバサイドでJavaScriptのコードを生成し、それをレスポンスとして返すJavaScriptの実行方法です。

サーバサイド側で使っているテンプレートやヘルパーなどを扱って手軽にJavaScript処理を記述できるメリットがある一方で、複雑なJavaScriptは管理が煩雑になるというデメリットがあります。

SJRはJavaScriptなので、ファイルは`XXX.js.erb`という形式になります。
これ自体のformatはJavaScriptなのですが、以下のようにSJRの中でHTMLのパーシャルファイルをレンダリングする場合、そのパーシャルのformatはHTMLです。

```erb
<h1>All messages:</h1>
<%= renders messages/_message.html.erb %> 
```

これをレンダリングすることを想定して、`.js`を指定した場合は`html`も検索対象に含めるような仕様になっているようです。

https://github.com/rails/rails/pull/39480/commits/5888c359e4221537e936e92f6dbac838ca098483

### この仕様に対する動向

:::message
記事執筆時点（2021/12/03）の情報です。
:::

jsを指定した場合にhtmlが条件として追加される仕様はだいぶ前からあったようです（Git Blameした限りでは、わりと最初期の頃からこの仕様でした）。

これに対し、2017年3月に以下のPRが上がりました。

https://github.com/rails/rails/pull/28251

js形式のテンプレートがない場合の挙動がわかりづらい的な内容のPRでしたが、「今この仕様で動いているアプリに対する対応はどうする？」という内容を議論したところで、マージされずにクローズしています。

ついで2020年5月にIssueおよびPRが上がりました。

https://github.com/rails/rails/issues/39475
https://github.com/rails/rails/pull/39476

既存のアプリはrespond_toを明示することを対策とした上で、認証トークン等が盗まれる可能性があることから、この仕様を廃止するという内容でした。

こちらも2020/8月に一度動きが止まっていますが、再度Openの状態になり放置されているようです。

### ここまでのまとめ

- `js`をフォーマットに指定した時に`html`も検索条件としてVIEWファイルを探索するのは、SJRを利用した際に、js.erbファイル内で定義しているHTMLのパーシャルをformat指定なしでレンダリングできるようにするため
- この挙動自体に対してIssueがいくつか投げかけられているが、今のところ修正の兆しはない

## 対応案

最後にここまでの事象に対して、HTMLを固定で返すようにするにはどうすればいいかのというお話です。

FJORD BOOT CAMPではいろいろなものにタグをつける機能が実装されており、そのタグ名がURLに利用されていました（`/users/tags/タグ名`）。

今回私が遭遇したのは、タグ名が`.js`で終わる場合に、表示が崩れるというIssueでした。
これはここまでで述べてきた通り、`.js`がformatとして認識され、一方SJRは使っていないために、該当のアクションに紐づくHTMLだけが描画されていたためです。

タグ名がいかなる形式であっても、HTMLを返すようにしたいので、下記のように`routes.rb`の中で`format`を指定し、解決しました。

```ruby:routes.rb
Rails.application.routes.draw do
  get 'home/index', format: "html"
end
```

https://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Resources.html#method-i-resources

## おわりに

対応自体は1行で済んでしまうようなものでしたが、「どうしてこういう挙動になるのか」「なぜこういう仕様なのか」が気になり、個人的に調査をはじめました。

Railsのソースやリポジトリを掘り進めていくのはだいぶ骨の折れる作業でしたが、なんとか諦めずに最後まで読み切ることができてよかったです。

## PR

今回の記事は[フィヨルドブートキャンプ Part 1 Advent Calendar 2021](https://adventar.org/calendars/6331)」の3日目の記事でした。
プログラミングスクール、FJORD BOOT CAMPはこちらから！

https://bootcamp.fjord.jp/

今回、Railsのソースを追うのに、Ruby専用IDEであるRubyMineを使いました！
Railsのソースは私のような初心者には静的リーディングが非常に難しかったのですが、ブレークポイントとウォッチを併用しながら、動的に読んでいくことで最後まで辿り着けました。

![](/images/why-rails-return-html-for-js-request/rubymine.png)

ZennでRubyMine入門という本を書いていますので、RubyMine使ってみようかな？という方はこちらもぜひ！🙇‍♂️

https://zenn.dev/ikuma/books/how-to-use-redimine
