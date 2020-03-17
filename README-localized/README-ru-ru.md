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
# Пакет SDK Outlook для iOS

**Важно!** Эта предварительная версия SDK устарела и больше не поддерживается. Рекомендуем использовать [Microsoft Graph](https://graph.microsoft.com/) и связанные с ним пакеты [Microsoft Graph SDK](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks).

Простая интеграция служб и данных из Outlook в собственные приложения iOS с помощью этой библиотеки Objective-C.

---

:exclamation:**ПРИМЕЧАНИЕ**. Этот код и связанные двоичные файлы выпущены в версии разработчика. Вы можете использовать эту библиотеку согласно условиям включенной в нее [ЛИЦЕНЗИИ](/LICENSE) и сообщать о проблемах в этом репозитории для неофициальной поддержки.

Сведения об официальной поддержке Майкрософт доступны [здесь][support-placeholder].

[support-placeholder]: https://support.microsoft.com/

---

Эта библиотека создается из метаданных API Outlook с помощью [Vipr] и [Vipr-T4TemplateWriter] и использует [общий стек клиента][orc-for-ios].

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## Быстрое начало работы

Чтобы использовать эту библиотеку в проекте, выполните общие действия, как описано ниже:

1. Настройте [Подфайл].
2. Настройте проверки подлинности.
3. Создайте клиент API.

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### Настройка

1. Создайте новый проект приложения XCode из заставки XCode. В диалоговом окне выберите "iOS" > "Приложение с одним представлением". Присвойте любое имя своему приложению. Мы применим имя *OutlookQuickStart*.

2. Добавьте файл в проект. В диалоговом окне выберите "iOS" > "Другое" > "Пустой" и назовите ваш файл `Podfile`.

3. Добавьте эти строки в Podfile, чтобы импортировать пакет SDK Outlook

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > ПРИМЕЧАНИЕ. Для получения подробной информации о Cocoapods и передовых методах для Podfiles прочитайте руководство [Использование Cocoapods].

4. Загрузка проекта XCode.

5. В командной строке перейдите в каталог проекта. Затем запустите `pod install`.

 > ПРИМЕЧАНИЕ: Установите Cocoapods в первую очередь. См. инструкции [здесь](https://guides.cocoapods.org/using/getting-started.html).

6. В том же месте в терминале выполните команду `open OutlookQuickStart.xcworkspace`, чтобы открыть рабочую область, содержащую исходный проект вместе с импортированными модулями в Xcode.

---

### Проверка подлинности и создание клиента

После подготовки проекта, на следующем этапе нужно инициализировать диспетчер зависимостей и клиент API.

:восклицание: Если вы еще не зарегистрировали приложение в Azure AD, это потребуется сделать до завершения этого шага, выполнив [следующие инструкции][MSDN Add Common Consent].

1. Щелкните правой кнопкой мыши папку OutlookQuickStart и выберите "Создать файл". В диалоговом окне выберите *iOS* > *Ресурс* > *Список свойств*. Назовите файл `adal_settings.plist`. Добавьте следующие ключи в список и установите их значения в соответствии с регистрацией вашего приложения. **Это всего лишь примеры; используйте собственные значения.**

 |Ключ|Значение|
|---|-----|
|ClientId|Пример: e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|Пример: https://my.client.app/|
|ResourceId|Пример: https://outlook.office.com/|
|AuthorityUrl|https://login.microsoftonline.com/common/|

2. Откройте ViewController.m в папке OutlookQuickStart. Добавьте зонтичный заголовок для заголовков, связанных с Outlook и ADAL.

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. Добавьте свойства для ADALDependencyResolver и MSOutlookClient в разделе расширения класса ViewController.m.

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. Инициализируйте преобразователь и клиент в методе viewDidLoad файла ViewController.m.

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. Перед использованием клиента требуется убедиться, что пользователь выполнил вход в интерактивном режиме хотя бы один раз. Для запуска последовательности входа в систему можно использовать `interactiveLogon` или `interactiveLogonWithCallback:`. В этом упражнении добавьте следующее в метод viewDidLoad из последнего шага:

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. Теперь вы можете безопасно использовать API-клиент.

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## Примеры
- [O365-iOS-Connect] — Начало работы и проверка подлинности <br />
- [O365-iOS-Snippets] - API запросы и ответы

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## Помощь
Прежде чем отправить запрос на включение внесенных изменений, необходимо подписать [Лицензионное Соглашение с Участником](https://cla.microsoft.com/). Чтобы заполнить лицензионное соглашение участника (CLA), нужно отправить запрос через форму, а затем подписать лицензионное соглашение участника в электронном виде, когда вы получите сообщение со ссылкой на документ по электронной почте.

Этот проект соответствует [Правилам поведения разработчиков открытого кода Майкрософт](https://opensource.microsoft.com/codeofconduct/). Дополнительные сведения см. на [странице вопросов и ответов по правилам поведения](https://opensource.microsoft.com/codeofconduct/faq/). Любые дополнительные вопросы и комментарии отправляйте по адресу [opencode@microsoft.com](mailto:opencode@microsoft.com).

## Лицензия
© Корпорация Майкрософт. Все права защищены. Лицензирован в рамках лицензии Apache версии 2,0.
