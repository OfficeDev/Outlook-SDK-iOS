---
page_type: sample
products:
- office-365
- office-outlook
languages:
- objc
extensions:
  contentType: samples
  createdDate: 11/12/2015 12:59:56 PM
---
# IOS 版 Outlook SDK

**重要:**このプレビュー SDK は廃止されており、保守は終了しています。代わりとして、[Microsoft Graph](https://graph.microsoft.com/) および関連する [Microsoft Graph SDK](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks) を使用することをお勧めします。

この Objective-C ライブラリを使用して、Outlook からネイティブ iOS アプリに簡単にサービスとデータを統合できます。

---

:exclamation:**注**:このコードと関連するバイナリは開発者としてリリースされます。このライブラリは、付属する[ライセンス](/LICENSE)の条件に従って自由にお使いいただけます。このレポジトリでの問題を報告すると、非公式のサポートを得られます。

公式の Microsoft サポートの詳細については、[こちら][support-placeholder]を参照してください。

[support-placeholder]: https://support.microsoft.com/

---

このライブラリは、[Vipr] および [Vipr-T4TemplateWriter] を使用して Outlook API のメタデータから生成され、[共有のクライアント スタック][orc-for-ios]を使用します。

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## クイック スタート

このライブラリをプロジェクトで使用するには、次の一般的な手順を後述する詳細に従って実行します。

1. [Podfile] を構成します。
2. 認証をセットアップします。
3. API クライアントを構築します。

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### セットアップ

1. Xcode スプラッシュ画面から新しい Xcode アプリケーション プロジェクトを作成します。ダイアログ ボックスで、[iOS]、[単一ビュー アプリケーション] の順に選択します。必要に応じて、アプリケーションに名前を付けます。ここでは、*OutlookQuickStart* という名前を付けます。

2. プロジェクトにファイルを追加します。ダイアログ ボックスから [iOS]、[その他]、[空] の順に選択し、ファイルに `Podfile` という名前を付けます。

3. Podfile に次の行を追加して、Outlook SDK をインポートします。

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > 注:Podfiles の Cocoapods やベスト プラクティスの詳細については、「Cocoapods を使用する」ガイドを参照してください。

4. XCode プロジェクトを閉じます。

5. コマンド ラインから、プロジェクトのディレクトリを変更します。`pod install` を実行します。

 > 注:最初に Cocoapods をインストールします。手順は[こちら](https://guides.cocoapods.org/using/getting-started.html)です。

6. 端末の同じ場所から、`open OutlookQuickStart.xcworkspace` を実行して、元のプロジェクトと Xcode でインポートされたポッドを含むワークスペースを開きます。

---

### クライアントを認証して構築する

プロジェクトが準備できたら、次の手順として、依存関係マネージャーと API クライアントを初期化します。

:exclamation:アプリを Azure AD でまだ登録していない場合、この手順を完了するには、[こちらの手順][MSDN Add Common Consent]に従って登録を行う必要があります。

1. [OutlookQuickStart] フォルダーを右クリックし、[新しいファイル] を選択します。 ダイアログ ボックスで、[*iOS*]、[*リソース*]、[*プロパティ一覧*] の順に選択します。ファイルに [`adal_settings.plist`] と名前を付けます。次のキーを一覧に追加し、その値をアプリ登録のものに設定します。**これらは単なる例です。必ず独自の値を使用してください。**

 |キー|値|
|---|-----|
|ClientId|例: e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|例: https://my.client.app/|
|ResourceId|例e: https://outlook.office.com/|
|AuthorityUrl|https://login.microsoftonline.com/common/|

2. OutlookQuickStart フォルダーから ViewController.m を開きます。Outlook のアンブレラ ヘッダーと ADAL 関連のヘッダーを追加します。

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. ViewController.m のクラス拡張セクションに ADALDependencyResolver および MSOutlookClient のプロパティを追加します。

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. ViewController.m ファイルの viewDidLoad メソッド内でリゾルバーとクライアントを初期化します。

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. クライアントを使用する前に、ユーザーが少なくとも 1 回は対話型にログオンしていることを確認する必要があります。`interactiveLogon` または `interactiveLogonWithCallback:` を使用して、ログオン シーケンスを開始できます。この演習では、最後の手順の viewDidLoad メソッドに次を追加します。

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. これで、API クライアントを安全に使用できるようになりました。

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## サンプル
- [O365-iOS-Connect] - 概要と認証 <br />
- [O365-iOS-Snippets] - API 要求と応答

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## 投稿
プル要求を送信する前に、[投稿者のライセンス契約](https://cla.microsoft.com/)に署名する必要があります。投稿者のライセンス契約 (CLA) を完了するには、ドキュメントへのリンクを含むメールを受信した際に、フォームから要求を送信し、CLA に電子的に署名する必要があります。

このプロジェクトでは、[Microsoft オープン ソース倫理規定](https://opensource.microsoft.com/codeofconduct/) が採用されています。詳細については、「[倫理規定の FAQ](https://opensource.microsoft.com/codeofconduct/faq/)」を参照してください。また、その他の質問やコメントがあれば、[opencode@microsoft.com](mailto:opencode@microsoft.com) までお問い合わせください。

## ライセンス
Copyright (c) Microsoft Corporation。All rights reserved.Licensed under the Apache License, Version 2.0.
