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
# SDK de Outlook para iOS

**Importante:** Este SDK ha quedado en desuso y ya no se mantiene. Le recomendamos que use [Microsoft Graph](https://graph.microsoft.com/) y los [SDK de Microsoft Graph](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks) asociados en su lugar.

Integrar fácilmente servicios y datos de Outlook en aplicaciones nativas de iOS usando esta biblioteca de Objective-C.

---

: exclamación:**NOTA**: Este código y los binarios asociados son liberados como un desarrollo. Es libre de usar esta biblioteca según los términos de su [LICENCIA](/LICENSE) incluida y de abrir los temas de esta repo para apoyo no oficial.

La información sobre el soporte técnico oficial de Microsoft está disponible [aquí][support-placeholder].

[support-placeholder]: https://support.microsoft.com/

---

Esta biblioteca se genera a partir de los metadatos de Outlook API usando [Vipr] y [Vipr-T4TemplateWriter] y utiliza una [pila de clientes compartida][orc-for-ios].

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## Inicio rápido

Para utilizar esta biblioteca en su proyecto, siga estos pasos generales, que se describen más adelante:

1. Configure un [Podfile].
2. Configure la autenticación.
3. Construir un cliente API.

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### Instalación

1. Crear un nuevo proyecto de aplicación de Xcode desde la pantalla de inicio de Xcode. En el diálogo, elige iOS > Aplicación de vista única. Nombre a su solicitud como desee; aquí asumiremos el nombre *OutlookQuickStart*.

2. Agregue un archivo al proyecto. Elija iOS > Otros > Vaciar del diálogo y nombre su archivo`Podfile`.

3. Añade estas líneas al Podfile para importar el Outlook SDK

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > NOTA: Para obtener información detallada sobre los Cocoapods y las mejores prácticas para los Podfiles, lea la guía [Using Cocoapods].

4. Cerrar el proyecto Xcode.

5. Desde la línea de comandos, cambie al directorio de su proyecto. Luego ejecute `pod install`.

 > NOTA: Instale Cocoapods primero, por supuesto. Instrucciones[aquí](https://guides.cocoapods.org/using/getting-started.html).

6. Desde la misma ubicación en la terminal, ejecute `abrir OutlookQuickStart.xcworkspace` para abrir un espacio de trabajo que contenga su proyecto original junto con los pods importados en Xcode.

---

### Autentificar y construir el cliente

Con el proyecto preparado, el siguiente paso es inicializar el administrador de dependencias y un cliente API.

exclamación: Si aún no ha registrado su aplicación en Azure AD, tendrá que hacerlo antes de completar este paso siguiendo [estas instrucciones][MSDN Add Common Consent].

1. Haga clic con el botón derecho del ratón en la carpeta OutlookQuickStart y elija "Nuevo Archivo". En el diálogo, seleccione*iOS*>*Recurso*> *Lista de propiedades*. Nombre el archivo`adal_settings. plist`. Agregue las siguientes claves a la lista y ajuste sus valores a los del registro de su aplicación. **Estos son sólo ejemplos; asegúrese de usar sus propios valores.**

 |Clave|Valor|
|---|-----|
|ClientId|Example: e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|Ejemplo: https://my.client.app/|
|ResourceId|Ejemplo: https://outlook.office.com/|
|AuthorityUrl|https://login.microsoftonline.com/common/|

2. Abra ViewController.m desde la carpeta OutlookQuickStart. Agregue el encabezado general de Outlook y los encabezados relacionados con ADAL.

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. Añadir propiedades para el ADALDependencyResolver y el MSOutlookClient en la sección de extensión de clases de ViewController.m.

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. Inicializar el resolver y el cliente dentro del método viewDidLoad del archivo ViewController.m.

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. Antes de usar el cliente, debe asegurarse de que el usuario se ha conectado de forma interactiva al menos una vez. Puede utilizar `interactiveLogon` o `interactiveLogonWithCallback:` para iniciar la secuencia de inicio de sesión. En este ejercicio, añada lo siguiente al método viewDidLoad del último paso:

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. Ahora puede usar con seguridad el API de cliente.

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## Ejemplos
- [O365-iOS-Connect] - Introducción y autenticación <br />
- [O365-iOS-Snippets] - Solicitudes y respuestas de la API

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## Colaboradores
Deberá firmar un [Contrato de licencia de colaborador](https://cla.microsoft.com/) antes de enviar la solicitud de incorporación de cambios. Para completar el Acuerdo de Licencia de Colaborador (CLA), deberá presentar una solicitud a través del formulario y luego firmar electrónicamente el Acuerdo de Licencia de Colaborador cuando reciba el correo electrónico que contiene el enlace al documento.

Este proyecto ha adoptado el [Código de conducta de código abierto de Microsoft](https://opensource.microsoft.com/codeofconduct/). Para obtener más información, vea [Preguntas frecuentes sobre el código de conducta](https://opensource.microsoft.com/codeofconduct/faq/) o póngase en contacto con [opencode@microsoft.com](mailto:opencode@microsoft.com) si tiene otras preguntas o comentarios.

## Licencia
Copyright (c) Microsoft Corporation. Todos los derechos reservados. Licenciado bajo la licencia de Apache, versión 2.0.
