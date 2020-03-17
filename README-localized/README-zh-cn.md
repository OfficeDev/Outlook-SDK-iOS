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
# Outlook SDK for iOS

**重要说明：**预览版 SDK 已弃用，不再对其进行维护。建议改用 [Microsoft Graph](https://graph.microsoft.com/) 和关联的 [Microsoft Graph Sdk](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks)。

使用此 Objective-C 库轻松将 Outlook 中的服务和数据集成到本机 iOS 应用中。

---

：感叹号：**注意**：此代码和关联的二进制文件面向开发人员发布。可根据所包含[许可证](/LICENSE)的条款，免费使用此库，并在非官方支持存储库中打开问题。

[此处][support-placeholder]提供有关 Microsoft 官方支持的信息。

[support-placeholder]: https://support.microsoft.com/

---

该库是使用 [Vipr] 和 [Vipr-T4TemplateWriter] 从 Outlook API 元数据生成的，并使用[共享客户端堆栈][orc-for-ios]。

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## 快速入门

若要在项目中使用此库，按照如下所述的常规步骤进行操作：

1. 配置 [Podfile]。
2. 设置身份验证。
3. 构建 API 客户端。

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### 设置

1. 从 Xcode 初始屏幕创建一个新的 Xcode 应用程序项目。在对话框中，选择“iOS”>“单视图应用程序”。根据需要为应用程序命名；我们将在此处使用名称 *OutlookQuickStart*。

2. 将文件添加到项目。在对话框中选择“iOS”>“其他”>“空”，并将文件命名为 `Podfile`。

3. 将这些行添加到 Podfile 中以导入 Outlook SDK

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > 注意：有关 Cocoapods 的详细信息和 Podfile 的最佳做法，请阅读[使用 Cocoapods]指南。

4. 关闭 Xcode 项目。

5. 从命令行，更改为项目目录。然后运行 `pod install`。

 > 注意：当然，请先安装 Cocoapods。[此处](https://guides.cocoapods.org/using/getting-started.html)提供了说明。

6. 在终端的同一位置执行 `open OutlookQuickStart.xcworkspace`，以打开一个工作区，其中包含原始项目以及 Xcode 中导入的 pod。

---

### 验证身份并构建客户端

随着项目的准备完毕，下一步是初始化依赖关系管理器和 API 客户端。

：感叹号：如果尚未注册应用程序至 Azure AD，需要按照“[这些说明][MSDN Add Common Consent]”在完成此步骤前进行注册。

1. 右键单击 OutlookQuickStart 文件夹，然后选择“新建文件”。 在对话框中，选择“*iOS*”>“*资源*”>“*属性列表*”。将文件命名为 `adal_settings.plist`。将以下密钥添加到列表中，并将其值设置为应用注册中的值。**这些只是示例；请确保使用自己的值。**

 |密钥|值|
|---|-----|
|ClientId|示例：e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|示例：https://my.client.app/|
|ResourceId|示例：https://outlook.office.com/|
|AuthorityUrl|https://login.microsoftonline.com/common/|

2. 从 OutlookQuickStart 文件夹中打开 ViewController.m。为与 Outlook 和 ADAL 相关的标头添加伞头。

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. 为 ViewController.m 的类扩展部分中的 ADALDependencyResolver 和 MSOutlookClient 添加属性。

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. 在 ViewController.m 文件的 viewDidLoad 方法中初始化解析器和客户端。

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. 在使用客户端之前，必须确保用户至少以交互方式登录一次。你可以使用 `interactiveLogon` 或 `interactiveLogonWithCallback:` 启动登录序列。在本练习中，将以下内容添加到上一步的 viewDidLoad 方法中：

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. 现在，你可以安全地使用 API 客户端。

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## 示例
- [O365-iOS-Connect] - 入门和身份验证 <br />
- [O365-iOS-Snippets] - API 请求和响应

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## 参与
你需要在提交拉取请求之前签署[参与者许可协议](https://cla.microsoft.com/)。要完成参与者许可协议 (CLA)，你需要通过表单提交请求，并在收到包含文件链接的电子邮件时在“参与者许可协议”上提供电子签名。

此项目已采用 [Microsoft 开放源代码行为准则](https://opensource.microsoft.com/codeofconduct/)。有关详细信息，请参阅[行为准则 FAQ](https://opensource.microsoft.com/codeofconduct/faq/)。如有其他任何问题或意见，也可联系 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

## 许可证
版权所有 (c) Microsoft Corporation。保留所有权利。按照 Apache 许可证版本 2.0 授予许可。
