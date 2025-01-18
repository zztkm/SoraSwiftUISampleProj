# Sora iOS SDK SwiftUI Sample

このサンプルは sora-ios-sdk の feature/swiftui-view ブランチに依存しているので、場合によっては動かない可能性もあります

※ sora-ios-sdk はまだ SwiftUI に公式に対応しておらず開発段階のため feature/swiftui-view に依存しています。

## プロジェクト構成について

Swift Package中心のプロジェクト構成にチャレンジしています。

- App: アプリケーション本体
- Core: App で利用するためのライブラリ
  - プロジェクトの依存関係などは Core/Package.swift を参照
  - 本当は Core の中身 (Package.swift など）をルートに配置したかったのですが、Xcode 16 ではその状態でマルチモジュール化できなかったので諦めました...
  - ただこの辺は深く学べていないので、いい方法を知ったときは修正したいと思います。

参考リンク

- [Swift Package中心のプロジェクト構成とその実践 by Daiki Matsudate](https://fortee.jp/iosdc-japan-2021/proposal/1338c9cc-363a-44a6-bbac-452b67b472fb)
- [Swift Package中心のプロジェクト構成とその実践を試してみる](https://harumi.sakura.ne.jp/wordpress/2023/06/09/swift-package%E4%B8%AD%E5%BF%83%E3%81%AE%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%A7%8B%E6%88%90%E3%81%A8%E3%81%9D%E3%81%AE%E5%AE%9F%E8%B7%B5%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6/)
- [既存の Xcode プロジェクトを SwiftPM でマルチモジュール化する最初のステップ](https://zenn.dev/kalupas226/articles/73118709e316ad)

