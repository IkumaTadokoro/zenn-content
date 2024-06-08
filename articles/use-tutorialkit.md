---
title: "TutorialKit を使って、インタラクティブなチュートリアルを手早く作成する"
emoji: "⏲️"
type: "tech" # tech: 技術記事 / idea: アイデア
topics: ["astro", "tutorialkit", "WebContainer"]
published: true
---

## はじめに

今朝タイムラインを眺めていたところ、StackBlitz が TutorialKit という新しいツールの提供を開始していました。ブラウザで動くインタラクティブなチュートリアルを効率的に作るためのツールのようです。

この記事では、TutorialKit を使ってチュートリアルを作成する方法と、TutorialKit の構造について簡単に紹介します。

https://twitter.com/elmd_/status/1798765386118373487

## TutorialKit とは

TutorialKit は インタラクティブなチュートリアルを作成するためのフレームワークです。提供は StackBlitz によって行われており、Astro と WebContainer API をベースにしています。

JavaScript フレームワークや UI ライブラリの使い方を学ぶためのチュートリアルを、コンテンツを配置するだけで簡単に作成することができます。

![プロジェクトに最初からインストールされているチュートリアルの画面](/images/use-tutorialkit/first-tutorial.png)

## TutorialKit の技術構成

TutorialKit は Astro をベースとしており、コンテンツ部分に Astro の Content Collections を、エディタやターミナル部分に WebContainer API をそれぞれ使用しています。

それらを含むフレームワークが Astro インテグレーションとして提供されており、プロジェクト側ではこれを利用することで、チュートリアルの作成を容易に行うことができます。

```tsx
import tutorialkit from '@tutorialkit/astro';
import { defineConfig } from 'astro/config';

export default defineConfig({
  integrations: [tutorialkit()],
});
```

https://github.com/stackblitz/tutorialkit

### Astro によるページレイアウト

Astro 部分では、基本となるレイアウトや設定を提供しています。

例えば大枠のレイアウトとルーティングは、[Astro のルーティング](https://docs.astro.build/en/guides/routing/#rest-parameters
)を用いて、`page/[...slug].astro` で定義されています。

https://github.com/stackblitz/tutorialkit/blob/main/packages/astro/src/default/pages/%5B...slug%5D.astro#L26-L47

![[...slug].astroで定義されているレイアウトと実際の画面を照らし合わせた図](/images/use-tutorialkit/astro-layout.png)

### WebContainer API によるエディタやターミナルの表示

エディタやターミナルなどのインタラクティブな部分は、別途 React を用いて実装されており、機能としては Web Container API、CodeMirror、Xterm.js を使用しています。

https://github.com/stackblitz/tutorialkit/blob/94546823c3393e4d3005ff78038119692475466b/packages/components/react/src/Panels/WorkspacePanel.tsx#L38

---

構成としては想像のつく部分が多いですが、ゼロから組み合わせるとなると、本題であるチュートリアルを作成するまでに時間がかかるので、ライブラリとして提供されているのは嬉しいですね。

## チュートリアルを作成する

ここからは、TutorialKit を使って実際にチュートリアルを作成してみます。

### プロジェクトの作成

`npm create tutorial`　コマンドを実行すると、チュートリアル作成のためのインタラクションが始まります。プロジェクト名やパッケージマネージャを指定して、プロジェクトを作成します。

```bash
npm create tutorial

┌   tutorialkit
│
◇  What's the name of your tutorial?
│  my-first-tutorial
│
●  We'll call your tutorial my-first-tutorial
│
◇  Where should we create your new tutorial?
│  ./my-first-tutorial
│
●  Scaffolding tutorial in path/to/my-first-tutorial
│
◇  Install dependencies?
│  Yes
│
◇  What package manager should we use?
│  bun
│
◇  Dependencies installed
│
◇  Initialize a new git repository?
│  Yes
│
◇  Git repository initialized
│
◆  Tutorial successfully created!
│
│  Next Steps
│
◇  1. cd ./my-first-tutorial - Navigate to project
│
◇  2. bun run dev - Start development server
│
◇  3. Head over to http://localhost:4321
│
└  You're all set!

Until next time 👋
```

### 作成されたチュートリアルを起動する

```bash
# プロジェクトに移動する
cd my-first-tutorial

# 開発サーバーを起動する
npm start
```

サーバを起動すると、デフォルトのチュートリアルを確認することができました。

![プロジェクトに最初からインストールされているチュートリアルの画面](/images/use-tutorialkit/first-tutorial.png)

## チュートリアルの概念と構造を理解する

デフォルトのチュートリアルをカスタマイズする前に、チュートリアルの構造を理解しておきます。

```
src
├── content
│   ├── config.ts
│   └── tutorial
│       ├── 1-basics
│       │   ├── 1-introduction
│       │   │   ├── 1-welcome
│       │   │   │   ├── _files
│       │   │   │   │   └── counter.js
│       │   │   │   ├── _solution
│       │   │   │   │   └── counter.js
│       │   │   │   └── content.md
│       │   │   └── meta.md
│       │   └── meta.md
│       └── meta.md
└── templates
    └── default
        ├── counter.js
        ├── index.html
        ├── javascript.svg
        ├── main.js
        ├── package-lock.json
        ├── package.json
        ├── public
        │   └── vite.svg
        └── style.css
```

### Parts, Chapters, Lessons

TutorialKit では、チュートリアルを Parts、Chapters、Lessons という単位で管理します。

実際の例を見た方がイメージがつきやすいと思うので、以下に[公式ドキュメントのサンプル](https://tutorialkit.dev/guides/creating-content/)を引用します。

```
- Part 1: Basics of Vite
  - Chapter 1: Introduction
    - Lesson 1: Welcome!
    - Lesson 2: Why Vite?
    - …
  - Chapter 2: Your first Vite project
- Part 2: Vite CLI
  - …
```

### チュートリアル (`src/content/tutorial`)

https://tutorialkit.dev/guides/creating-content/#_top

Astro の Content Collections を使って、チュートリアルを管理します。

各ディレクトリ配下に格納された Markdown ファイルが、Parts、Chapters、Lessons の各コンテンツとなります。

Markdown ファイルがどのタイプに相当するかは、YAML フロントマターの `type` フィールドで指定します。

#### Parts / Chapters

フロントマターのみを定義します（フロントマター以外を定義しても、無視されます）。

```yaml
type: part
title: Basics of Vite
```

タイトルのほかに、その Tutorial、Parts ないしは Chapters 固有の環境設定を記述することもできます。

例えばプロジェクト作成時に入っているサンプルチュートリアルでは、チュートリアル単位で Vite を起動するような設定が記述されています。

```yaml
---
type: tutorial
title: Basics
mainCommand: ['npm run dev', 'Starting http server']
prepareCommands:
  - ['npm install', 'Installing dependencies']
---
```

設定できるフロントマターについては、[Tutorial のドキュメントにある Configuration のページ](https://tutorialkit.dev/guides/configuration/)を参照してください。

#### Lessons

実際にドキュメントやエディタが表示されるセクションです。フロントマターに加えて、コンテンツを記述します。

```markdown
---
type: lesson
title: Welcome to TutorialKit
focus: /counter.js
---

# Welcome to TutorialKit

Hey there, and welcome to TutorialKit 👋!
```

設定できるオプションは Parts / Chapters と同様です。

デフォルトで生成されているフォルダでは、コンテンツを示す Markdown ファイルの他に、`_files` ディレクトリと `_solution` ディレクトリが存在します。

```
1-welcome
├── _files
│   └── counter.js
├── _solution
│   └── counter.js
└── content.md
```

`_files` ディレクトリにはエディタに表示されるファイルを、`_solution` ディレクトリには解答例を格納します。

初期表示時には `_files` ディレクトリの内容が表示され、エディタ上の「Reset」ボタンを押すと `_solution` ディレクトリの内容を表示することができます。

![filesの内容とsolutionの内容をチュートリアルのResetボタンで切り替えている](/images/use-tutorialkit/toggle-solution.gif)

### テンプレート (`src/templates`)

https://tutorialkit.dev/guides/creating-content/#code-templates

プレビュー用のコードを動作させるためには一式のコードが必要ですが、すべてのレッスンごとにコードを格納するのは手間です。

TutorialKit ではベースとなるプロジェクトをテンプレートとして用意し、レッスンごとに差分を適用することで、コードの管理を簡略化しています。

例えばデフォルトで作成されているフォルダでは、Vite でのアプリケーションのテンプートが格納されています。

## チュートリアルをカスタマイズする

構造がわかったところで、新たに Lesson を追加してみます。今回は Vite で構成された React アプリで Hello World を表示するチュートリアルを作成します。

### テンプレートを追加する

現在は Vite + JavaScript のサンプルのテンプレートしかありませんので、React のテンプレートを追加します。

`src/templates` ディレクトリにアプリケーションとして動作する内容が格納されていれば良いので、ここで Vite の生成コマンドを実行します。

```bash
cd src/templates
npx create-vite react-ts --template react-ts
```

```
src/templates
├── default/...
└── react-ts
    ├── README.md
    ├── index.html
    ├── package.json
    ├── public
    │   └── vite.svg
    ├── src
    │   ├── App.css
    │   ├── App.tsx
    │   ├── assets
    │   │   └── react.svg
    │   ├── index.css
    │   ├── main.tsx
    │   └── vite-env.d.ts
    ├── tsconfig.json
    ├── tsconfig.node.json
    └── vite.config.ts
```

新たにテンプレートが追加できました。

### レッスンを追加する

新たに Lesson を追加するために、`src/content/tutorial` ディレクトリに新しいディレクトリを作成します。ここでは 1-basics のとなりに 2-hello-world というディレクトリを作成し、その中に `content.md` を追加します。

````markdown
---
type: lesson
title: Hello World
---

# Hello World

`<div>` の中身を変更して、`Hello, World!` と表示されるようにしましょう。

```tsx add={4}
export default function App() {
return (
    <div>
    Hello, World!
    </div>
);
}
```
````

http://localhost:4321/1-basics/1-introduction/2-hello-world にアクセスすると、新たに追加した Lesson が表示されました。

![新しく追加したレッスンが表示されているスクリーンショット](/images/use-tutorialkit/new-lesson.png)

### テンプレートを適用する

次に先ほど追加した React のテンプレートを、新たに追加した Lesson のプレビューで表示されるように設定します。

テンプレート自体はどの階層においても適用することができますが、今回は既存のレッスンが影響を受けないように、新たに追加した Lesson にのみ適用します。

````diff yaml
---
type: lesson
title: Hello World
+ template: react-ts
+ mainCommand: ['npm run dev', 'Starting http server']
+ prepareCommands:
+   - ['npm install', 'Installing dependencies']
---

# Hello World

`<div>` の中身を変更して、`Hello, World!` と表示されるようにしましょう。

```tsx add={4}
export default function App() {
  return (
    <div>
      Hello, World!
    </div>
  );
}
```
````

![Reactアプリが追加で描画されるようになった](/images/use-tutorialkit/apply-template.png)

### 問題と解答を追加する

最後に問題と回答を追加します。挙動を見る限りでは、テンプレートと同じ階層にファイルを配置することで、プレビューとして表示される内容をオーバライドできるようです。

今回は `src/templates/react-ts/src/App.tsx` をオーバーライドする形で、Hello, World! と書き換えてもらう問題を用意します。

```tsx:_files/src/App.tsx
import './App.css';

export default function App() {
  return (
    <div>
      {/* Change the content of <div> to display "Hello, World!" */}
      Hello, TutorialKit!
    </div>
  );
}
```

```tsx:_solution/src/App.tsx
import './App.css';

export default function App() {
  return (
    <div>
      Hello, World!
    </div>
  );
}
```

合わせて問題を開いた際に、src/App.tsx にフォーカスが当たるように設定します。

```diff markdown
---
type: lesson
title: Hello World
template: react-ts
mainCommand: ['npm run dev', 'Starting http server']
prepareCommands:
  - ['npm install', 'Installing dependencies']
+ focus: /src/App.tsx
---
```

これで初期表示時には `_files/src/App.tsx` が表示され、解答を切り替えることができるようになりました！

![レッスンの完成系](/images/use-tutorialkit/complete-lesson.png)

## おわりに

WebContainer API を用いたチュートリアルのアイデア自体は以前からありますが、TutorialKit を用いることで、コンテンツ管理だけに集中してチュートリアルを作成することができ、ちょっとした教育用に便利だと感じました。

個人的には Next.js で使えるといいなと思っていたのですが、現状テンプレートに Next.js を追加してレンダリングしようとすると、エラーが発生してしまい、利用することができませんでした（WebContainer API 自体だけで言えば、Next.js でも利用可能なはずなので、短期的な問題かもしれません）。

とはいえ先に述べた通り、コンテンツを設定するだけでチュートリアルができるのは魅力的です。そのため今後教育視点のドキュメントや、自分用のデモありメモを作成する際には TutorialKit も選択肢に入れてみたいと思います。
