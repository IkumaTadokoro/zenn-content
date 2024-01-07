---
title: "Next.js の dev サーバーが HTTPS で立ち上がる仕組み"
emoji: "🌊"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: [Nextjs, https]
published: true
---

## Next.js 13.5 からは dev サーバーが HTTPS で立ち上がる

Next.js 13.5 からは dev サーバーが HTTPS で立ち上がるようになっています。

```bash
next dev --experimental-https
```

> [Feature] HTTPS support for development: next dev --experimental-https

https://nextjs.org/blog/next-13-5

すべての開発内容に HTTPS が必要なわけではありませんが、例えば認証系を試す際に認証プロバイダによっては HTTPS が必須だったりするので、そのような場合に便利です[^1]。

ローカル開発環境の HTTPS 化自体は、Next.js 13.5 以前でも実現できました。しかし起動スクリプトとして組み込まれているのを私はみたことがなく、Next.js の仕組みが汎用的に使えるものであれば自分の別のプロジェクトでも npm scripts として応用できるのでは？と思い、調べてみました。

:::message
この記事では 2024/01/07 時点で最新である Next.js v14.0.5-canary.42 のコードを参照しています。
HTTPS 化の experimental が外れることで挙動の変更の可能性がありますが、基本的に証明書を発行する方法自体は変わらないはずです。
:::

## 結論

- Next.js の --experimental-https オプションでは、内部的に mkcert を利用して自己証明書を生成している。
- 処理としては mkcert のバイナリをダウンロードして自己証明書を発行し、それをサーバ（Node.js の https モジュール）のオプションとして渡している。

## Next.js の --experimental-https オプションの挙動

### エントリポイント

Next.js の CLI は `next` に続く第一引数をコマンドとして解釈し、指定されたコマンドに応じて動的に実行するモジュールを切り替えています。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/bin/next.ts#L72

`next dev` であれば `cli/next-dev` を import　し、`nextDev` を実行しています。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/lib/commands.ts#L5-L18

### `runDevServer`: CLIから開発サーバ起動のブリッジ 

`cli/next-dev#nextDev` では `next dev` で指定されたオプションを解釈し、適当な開発サーバを起動します。最後に実行されるのが `runDevServer` です。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/cli/next-dev.ts#L295-L331

この処理の中で `--experimental-https` が指定されている場合の分岐が加わります。`--experimental-https` には 2 つの挙動があります。

1. `--experimental-https-key` と `--experimental-https-cert` が指定されている場合は、指定されたキーと証明書を使って HTTPS サーバを起動する。
2. `--experimental-https` のみ指定されている場合は、自己証明書を生成して HTTPS サーバを起動する。

1 の挙動について、https 化の機能が実験的であるためにコマンドラインオプションとして実装されていますが、将来的に experimental が外れた場合には環境変数での設定に置き換えられる可能性があります。[^2]

実際にサーバが立ち上がる部分を一旦保留し、2 の挙動における自己証明書の生成について確認します。

### `createCertificate`: 自己証明書の発行

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/lib/mkcert.ts

ファイル名からもわかるように、このモジュールは [mkcert](https://github.com/FiloSottile/mkcert) を使って自己証明書を生成しています。

処理の流れは以下の通りです。

1. プラットフォームに応じた mkcert のバイナリを、mkcert の GitHub リポジトリからダウンロード
2. mkcert を利用してルート認証局の証明書と秘密鍵を作成
   - 実際に発火するコマンド（オプション指定なし）: `mkcert -install -key-file 'certificates/localhost-key.pem' -cert-file 'certificates/localhost.pem' localhost 127.0.0.1 ::1 example.com`
   - `-key-file` オプションでは生成される秘密鍵の保存先ファイルパスを指定します。`-cert-file` オプションでは生成される証明書の保存先ファイルパスを指定します。
3. 生成した証明書を .gitignore に追加
4. 秘密鍵、証明書、ルート認証局の証明書を値として返却

### `startServer`: 開発サーバの起動

`runDevServer` では子プロセスとして　`startServer` を実行し、`nextWorkerReady` が発火されたタイミングで証明書を含むオプションを渡します。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/cli/next-dev.ts#L246-L268

`startServer` では証明書が指定されている場合、 Node.js の `https` モジュール[^3]を使って HTTPS サーバを起動します。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/packages/next/src/server/lib/start-server.ts#L172-L180

これによって HTTPS 化された開発サーバーが立ち上がります。

## 余談: --experimental-https オプションのテスト

こういう類のテストをどうやるんだろう？と思って PR を探していたら、コンソールの出力結果を確認するテストでした。

https://github.com/vercel/next.js/blob/9d8015ded3bf2a9317ee47f550612d0d92bd4cef/test/integration/cli/test/index.test.js#L645-L672

アサーションとして使用されている `check` メソッドは Next.js 内で使用されているテストユーティリティのようです。

https://github.com/vercel/next.js/blob/af24c45398f33a3ec51dbb020424e972c8a09e14/test/lib/next-test-utils.ts#L599-L631

## おわりに

「利用用途はないけど、[Remix 製の個人ブログ](https://ikuma-t.com)で試してみるかあ」と思って、Remix のドキュメントをみたら、ここまで確認した内容とほぼ同じことが書いてあることに気がつきました（そしてもういいかと思って https 化をやめました）。

https://remix.run/docs/en/main/guides/local-tls

## 参考

- [ローカルでの開発に HTTPS を使用する方法](https://web.dev/articles/how-to-use-local-https?hl=ja)
- [ローカル開発環境の https 化](https://blog.jxck.io/entries/2020-06-29/https-for-localhost.html)

[^1]: その他の場合として https のみで発生する挙動の確認で必要になります。参考: https://web.dev/articles/when-to-use-local-https?hl=ja
[^2]: https://github.com/vercel/next.js/pull/54016/files#r1294114294
[^3]: https://nodejs.org/api/https.html#httpscreateserveroptions-requestlistener