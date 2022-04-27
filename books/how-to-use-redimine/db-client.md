---
title: 'DBクライアント'
---

## データベースツールウィンドウ

本ChapterではRailsでの開発に役立つ、RubyMineのデータベースツールを紹介します。

RubyMineには複数のツールウィンドウがありますが、画面右側の「Database」タブを選択することで、データベースツールウィンドウを開くことができます。

データベースツールウィンドウは独立したDBクライアントであるため、接続情報さえ登録すれば開発しているアプリに関係ないDBを操作することもできますが、今回はRailsアプリに紐づくDBを操作する方法を記載します。

![](/images/db-client/rubymine-210820-10:31:52.png)

## DB接続の登録

データベースをオープンするためには、接続情報を登録する必要があります。

ここではSQLiteとPostgreSQLを用いた接続を例にして、接続情報の登録方法を説明します。その他のDBの接続方法について、基本的にはPostgreSQLの接続方法を参考にしてください。

### SQLiteでの接続方法

![](/images/db-client/db-open.png)

「Database」タブを選択して、データベースツールウィンドウを開き、「+」 > 「Data Source」 > 「SQLite」の順に選択します。

![](/images/db-client/sqlite-connection.png)

設定ダイアログが開くので、「File」に接続に使用するファイルを指定します（「…」からファイルエクスプローラを開いて直接選択することができます）。
(画像はデータベース接続先を`db/development.sqlite3`としている例です)

![](/images/db-client/sqlite-connection-test.png)

ファイルを指定したら、「Test Connection」を選択して疎通確認を行います。「Succeed」と出れば接続完了です。

### PostgreSQLでの接続方法

サンプルとして次のような設定で作成されたDBに対して、接続を行います。

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: postgre_sample_development
  username: postgre_sample
  host: localhost
  port: 5432
```

![](/images/db-client/db-open-pg.png)

「Database」タブを選択して、データベースツールウィンドウを開き、「+」 > 「Data Source」 > 「PostgreSQL」の順に選択します。

![](/images/db-client/pg-connection.png)

設定ダイアログが開くので、HostやPortの情報を接続先のDBに合わせて設定します。設定が完了したら、「Test Connection」を選択して疎通確認を行い、「Succeed」と出れば接続完了です。

## オブジェクトの参照

データベースツールウィンドウでは、接続したDBに登録されているオブジェクトがツリー構造で表示されています。
tables > テーブル一覧 > columns > そのテーブルのカラム一覧 という形で順をおって確認することができます。

![](/images/db-client/rubymine-210820-10:55:13.png)

テーブルを選択して開くことで、エディタ上にそのテーブルに登録されているレコードが表示されます。
エディタ上に表示されたデータはスプレッドシートのように、直接編集することができます（登録・更新・削除が可能です）。

基本的にはデータを直接編集することは望ましくないですが、動作確認用にちょっとしたテストデータを作成する際には重宝します。

![](/images/db-client/how-to-show-data-grid.gif)

またテーブルを選択し、`F1`を入力することで、QuickDefinitionをプレビューすることができます。 選択しているテーブルのDDLと最初の数件のデータを参照することができます。

![](/images/db-client/how-to-show-quick-definition.gif)

## クエリの実行（コンソール）

Jump to Query Console...（`⌘` + `Shift` + `F10`）を選択することで、クエリコンソールを開くことができます。

![](/images/db-client/how-to-open-query-console.gif)

クエリコンソールはその名の通り、接続中のDBに対してSQLでクエリを発行するためのコンソールです。
直接SQLを記述し、Execute（`⌘` + `Enter`）を選択することで、クエリの実行結果を確認することができます。

クエリを入力する際にも、ライブテンプレート（`⌘` + `J`）とインテリセンス（`⌃` + `Space`）を利用することができます。
特にインテリセンスについては、表別名から列名を取得することができるので便利です。

![](/images/db-client/how-to-use-complete-at-query-console.gif)

## ダイアグラムの表示

ER図とまではいかないですが、対象のDBに登録されているテーブル一覧とその関係性を表示してくれます。

![](/images/db-client/rubymine-210820-11:18:48.png)

データベースツールウィンドウから、tablesを右クリックし、コンテキストメニュー > Diagrams > Show Visualization... > Database Schema Diagram を選択することで、そのスキーマに存在するテーブルの関係図を表示することができます。

![](/images/db-client/how-to-use-diagrams.gif)

テーブルの関係性をさっと一覧したい時に便利です。

## その他の機能

他にもDDLを自動作成する、テーブル定義を変更する、TRUNCATEを実行する...といった機能がありますが、ActiveRecordというORMを介している以上、あまりDBを直接操作するのはおすすめできません。

本Chapterで紹介した機能で大部分は賄えると思いますが、その他の機能も気になる方は以下を読んでもらえると理解が深まると思います。

https://pleiades.io/help/ruby/relational-databases.html
