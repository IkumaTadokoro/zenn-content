---
title: "見た目を変更する"
---

# エディタの見た目を変える（スイッチャー経由）：Quick Switch Scheme（`⌘` + \`）

このChapterではRubyMineの見た目を変える方法について紹介します。

紹介する機能を利用する際に、共通でクイックスイッチャーを利用すると便利です。

![](/images/appearance/how-to-show-switcher.gif)

（`⌘` + \`）を入力すると、エディタの見た目に関するクイックスイッチャーが開きます。
以降クイックスイッチャーという場合には、この画面を開くことと読み替えてください。

## テーマを変更する

![](/images/appearance/how-to-change-theme.gif)

クイックスイッチャーからThemeを選択することで、インストールされているテーマを切り替えることができます。

使用できるテーマはプラグインとしてインストールできますので、MarketPlaceで「theme」と検索してお好みのテーマを探してみてください。

## 背景画像を設定する

エディタに表示されている背景画像を表示することができます（このChapterはわかりやすいように、背景画像を変更しています）。

![](/images/appearance/rubymine-210822-13:38:54.png)

Preferences（`⌘` + `,`） > Appearance & Behaviour > Appearance のUI Optionsというセクションに「BACKGROUND IMAGE」というボタンがあるので、これを選択します。

![](/images/appearance/rubymine-210822-13:39:04.png)

「Image:」に画像を指定することで、その画像を背景に表示することができます。
どこまで画像を表示するか、透過度をどうするか、配置をどうするか、など細かい設定もできるので、お好みで設定してみてください。

## フルスクリーンモード：Enter Full Screen（`⌃` + `⌘` + `F`）

![](/images/appearance/how-to-enter-full-screen.gif)

（`⌃` + `⌘` + `F`）を入力することで、フルスクリーンモードの切り替えができます。
もしくはクイックスイッチャーを開き、View Modeから Enter Full Screenを選択することでも切り替え可能です。

### 集中モード：Enter Distraction Free Mode

![](/images/appearance/how-to-enter-distraction-free-mode.gif)

クイックスイッチャー > View Mode > Enter Distraction Free Mode を選択することで、集中モードに切り替えることができます（元に戻す場合は逆操作を行います）。

このモードではエディタだけが表示され、他のツールウィンドウはタブを含めてすべて非表示になります。
ただし、ショートカットを利用することで、各ウィンドウを開くことは可能です。

### Zenモード：Enter Zen Mode

![](/images/appearance/how-to-enter-zen-mode.gif)

クイックスイッチャー > View Mode > Enter Zen Mode を選択することで、禅モードに切り替えることができます。

このモードは集中モードをフルスクリーンモードで表示したものになります。
そのため元に戻す場合は、集中モードの解除とフルスクリーンモードの解除を行います。

### プレゼンテーションモード：Enter Presentation Mode

![](/images/appearance/how-to-enter-presentation-mode.gif)

クイックスイッチャー > View Mode > Enter Presentation Mode を選択することで、プレゼンテーションモードに切り替えることができます。

このモードは全画面表示に加えて、フォントサイズを拡大し、画面共有時にRubyMineの操作が見えやすくなるようにします。

![](/images/appearance/rubymine-210822-13:55:43.png)

なおプレゼンテーションモード表示におけるフォントサイズを変更するには、
Preferences（`⌘` + `,`） > Appearance & Behaviour > Appearance のPresentation ModeセクションにあるFontSizeを変更します。

## フォントサイズを変更する

![](/images/appearance/rubymine-210822-13:58:44.png)

エディタのフォントサイズを変更するには、Preferences（`⌘` + `,`） > Editor > Color Scheme > Color Scheme Fontを開き、Sizeを変更します。
これはエディタ上のフォントサイズの設定であるため、コンソール上のフォントサイズも変更する場合は、ツリー上でColor Scheme Fontの下にあるConsole Fontから同様に設定します。
