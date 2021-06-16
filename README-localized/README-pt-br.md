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
# SDK do Outlook para iOS

**Importante:** Este SDK de visualização foi substituído e não está mais sendo mantido. Recomendamos que você use o [Microsoft Graph](https://graph.microsoft.com/) e os [SDKs associados do Microsoft Graph](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks).

Integre com facilidade serviços e dados do Outlook com aplicativos nativos iOS usando a biblioteca Objetiva-C.

---

:exclamação:**Observação**: Esse código e os binários associados são lançados como desenvolvedores. Você tem liberdade para usar essa biblioteca de acordo com os termos da [LICENÇA](/LICENSE) incluída e para abrir questões nesse repositório para obter suporte não oficial.

As informações sobre o suporte oficial da Microsoft estão disponíveis [aqui][support-placeholder].

[support-placeholder]: https://support.microsoft.com/

---

Essa biblioteca é gerada a partir dos metadados da API do Outlook usando [Vipr] e [Vipr-T4TemplateWriter] e usa uma[pilha de cliente compartilhada][orc-for-ios].

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## Início rápido

Para usar essa biblioteca em seu projeto, siga estas etapas gerais, conforme descrito abaixo:

1. Configurar um [Podfile].
2. Configure a autenticação.
3. Construir um cliente da API.

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### Configuração

1. Crie um novo projeto do aplicativo Xcode na tela inicial do Xcode. Na caixa de diálogo, escolha iOS > Aplicativo de modo de exibição único. Nomeie seu aplicativo como quiser; vamos nomear *MSGraphQuickStart* aqui.

2. Adicionar um arquivo ao projeto. Escolha iOS > Outro > Esvaziar da caixa de diálogo e nomear seu arquivo `Podfile`.

3. Adicionar essas linhas ao Podfile para importar o SDK do Outlook

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > OBSERVAÇÃO: Para obter informações detalhadas sobre Cocoapods e as práticas recomendadas para Podfiles, leia o guia [using Cocoapods].

4. Baixar o projeto do XCode.

5. Na linha de comando, altere para o diretório do seu projeto. Então execute `instalar pod`.

 > OBSERVAÇÃO: Primeiro, instale o Cocoapods. Instruções [aqui](https://guides.cocoapods.org/using/getting-started.html).

6. No mesmo local no terminal, execute `abrir OutlookQuickStart.xcworkspace` para abrir um espaço de trabalho que contenha seu projeto original juntamente com pods importados no Xcode.

---

### Autenticar e construir cliente

Com o projeto preparado, a próxima etapa é inicializar o gerenciador de dependências e um cliente API.

:exclamação: Se você ainda não registrou seu aplicativo no Azure AD, é necessário fazer isso antes de concluir esta etapa, seguindo [estas instruções][MSDN Add Common Consent].

1. Clique com o botão direito do mouse na pasta OulookQuickStart e escolha "Novo Arquivo". Na caixa de diálogo, selecione *iOS* > *Recurso* > *Lista de propriedades*. Nomeie o arquivo `adal_settings. plist`. Adicione as seguintes teclas à lista e defina seus valores às do registro do aplicativo. **Esses são apenas exemplos; certifique-se de usar seus próprios valores.**

 |Chave|Valor|
|---|-----|
|ClientId|Exemplo: e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|Exemplo: https: //my.client.app/|
|ResourceId|Exemplo: https: //outlook.office.com/|
|AuthorityUrl|https: //login.microsoftonline.com/common/|

2. Abra ViewController.m na pasta OulookQuickStart. Adicione o cabeçalho abrangente para cabeçalhos relacionados ao Outlook e ADAL.

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. Adicione propriedades ao ADALDependencyResolver e MSOutlookClient na seção de extensão da classe do ViewController.m.

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. Inicialize o solucionador e o cliente no método viewDidLoad do arquivo ViewController.m.

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. Antes de usar o cliente, certifique-se de que o usuário tenha sido conectado de forma interativa pelo menos uma vez.  Você pode usar `interactiveLogon` ou `interactiveLogonWithCallback:` para iniciar a sequência de logon. Neste exercício, adicione o seguinte ao método viewDidLoad na última etapa:

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. Agora você pode usar o cliente da API com segurança.

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## Exemplos
- [O365-iOS-conexão] - Introdução e autenticação <br />
- [O365-iOS-Snippets] - solicitações e respostas da API

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## Colaboração
Assine o [Contrato de Licença de Colaborador](https://cla.microsoft.com/) antes de enviar a solicitação pull. Para receber o Contrato de Licença do Colaborador (Contributor License Agreement (CLA)), você deve enviar uma solicitação através do formulário e assinar eletronicamente o CLA ao receber e-mails com o link para o documento.

Este projeto adotou o [Código de Conduta de Código Aberto da Microsoft](https://opensource.microsoft.com/codeofconduct/).  Para saber mais, confira [Perguntas frequentes sobre o Código de Conduta](https://opensource.microsoft.com/codeofconduct/faq/) ou contate [opencode@microsoft.com](mailto:opencode@microsoft.com) se tiver outras dúvidas ou comentários.

## Licença
Copyright (c) Microsoft Corporation. Todos os direitos reservados. Licenciado na licença do Apache, versão 2,0.
