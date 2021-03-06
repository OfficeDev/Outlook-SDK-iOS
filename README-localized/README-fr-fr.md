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
# Kit de développement (SDK) Outlook pour iOS

**Important :** Ce kit de développement logiciel est devenu obsolète et ne fait plus l’objet de mise à jour. Nous vous recommandons d’utiliser [Microsoft Graph](https://graph.microsoft.com/) ainsi que les [kits de développement de Microsoft Graph associés](https://developer.microsoft.com/en-us/graph/code-samples-and-sdks) à la place.

Intégrez facilement les services et les données de Outlook dans les applications iOS natives à l’aide de cette bibliothèque Objective-C.

---

: point d’exclamation :**NOTE** : Ce code et les fichiers binaires associés sont publiés en tant que développeur. Vous pouvez utiliser cette bibliothèque conformément aux termes de la [LICENCE](/LICENSE) de inclus et pour ouvrir les problèmes dans le cadre de ce repo.

Des informations sur le support Microsoft officiel sont disponibles [ici][support-placeholder].

[support-placeholder]: https://support.microsoft.com/

---

Cette bibliothèque est générée à partir des métadonnées de l’API Outlook à l’aide de [Vipr] et [Vipr-T4TemplateWriter] et utilise une [pile client partagée][orc-for-ios].

[Vipr]: https://github.com/microsoft/vipr
[Vipr-T4TemplateWriter]: https://github.com/msopentech/vipr-t4templatewriter
[orc-for-ios]: https://github.com/msopentech/orc-for-ios

## Démarrage rapide

Pour utiliser cette bibliothèque dans votre projet, suivez ces étapes générales, comme décrit ci-dessous :

1. Configurer une [Podfile].
2. Mettre en place une authentification.
3. Construire un client API.

[Podfile]: https://guides.cocoapods.org/syntax/podfile.html

### Configuration

1. Créer un nouveau projet d'application Xcode à partir de l'écran d'accueil Xcode. Dans la boîte de dialogue, sélectionnez iOS > Application à affichage unique. Nommez votre application comme vous le souhaitez. Nous prendrons ici le nom *OutlookQuickStart*.

2. Ajouter un fichier au projet. Sélectionnez iOS > Autres > Vide dans la boîte de dialogue, puis nommez votre fichier `Podfile`.

3. Ajoutez ces lignes au Podfile pour importer le kit de développement logiciel (SDK) Outlook

 ```ruby
 source 'https://github.com/CocoaPods/Specs.git'
 xcodeproj 'OutlookQuickStart'
 pod 'MSOutlook-SDK-iOS'
 ```

 > REMARQUE : Pour plus d’informations sur Cocoapods et les pratiques recommandées pour Podfiles, consultez le Guide [Using Cocoapods].

4. Fermer le projet XCode.

5. À partir de la ligne de commande, passez au répertoire de votre projet. Ensuite, exécutez `pod install`.

 > REMARQUE : Installez Cocoapods tout d’abord. Instructions [ici](https://guides.cocoapods.org/using/getting-started.html).

6. À partir du même emplacement sur le terminal, exécutez `ouvrir OutlookQuickStart.xcworkspace` pour ouvrir un espace de travail contenant votre projet d’origine, ainsi que des goussets importés dans Xcode.

---

### Authentifier et construire le client

Une fois votre projet préparé, l’étape suivante consiste à initialiser le gestionnaire de dépendances et un client API.

: point d’exclamation : Si vous n’avez pas encore enregistré votre application dans Azure AD, vous devez le faire avant d’effectuer cette étape en suivant [ces instructions][MSDN Add Common Consent].

1. Cliquez avec le bouton droit sur le dossier OutlookQuickStart, puis sélectionnez « Nouveau fichier ». Dans la boîte de dialogue, sélectionnez *iOS* > *Ressource* > *Liste de propriétés*. Nommez le fichier `adal_settings. plist`. Ajoutez les clés suivantes à la liste et attribuez-leur des valeurs à partir de l’inscription de votre application. **Il s’agit simplement d’exemples. Veillez à utiliser vos propres valeurs.**

 |Key|Valeur|
|---|-----|
|ClientId|Exemple : e59f95f8-7957-4c2e-8922-c1f27e1f14e0|
|RedirectUri|Exemple : https://my.client.app/|
|ResourceId|Exemple : https://outlook.office.com/|
|AuthorityUrl|https://login.microsoftonline.com/common/|

2. Ouvrez ViewController.m à partir du dossier OutlookQuickStart. Ajoutez l'en-tête parapluie pour les en-têtes associées à Outlook et ADAL.

 ```objective-c
 #import <MSOutlook.h>
 #import <impl/ADALDependencyResolver.h>
 #import <ADAuthenticationResult.h>
 ```

3. Ajoutez des propriétés pour ADALDependencyResolver et MSOutlookClient dans la section extension de classe de ViewController.m.

 ```objective-c
 @interface ViewController ()
 
 @property (strong, nonatomic) ADALDependencyResolver *resolver;
 @property (strong, nonatomic) MSOutlookServicesClient *outlookClient;
 
 @end
 ```

4. Initialisez le programme de résolution et le client dans la méthode viewDidLoad du fichier ViewController.m.

 ```objective-c
 - (void)viewDidLoad {
     [super viewDidLoad];
     
    self.resolver = [[ADALDependencyResolver alloc] initWithPlist];
    
    self.outlookClient = [[MSOutlookClient alloc] initWithUrl:@"https://outlook.office.com/api/v2.0" dependencyResolver:self.resolver];
    }
 ```

5. Avant d’utiliser le client, vous devez vous assurer que l’utilisateur a été connecté de façon interactive au moins une fois. Vous pouvez utiliser `interactiveLogon` ou `interactiveLogonWithCallback :` pour initialiser la séquence d’ouverture de session. Dans cet exercice, ajoutez les informations suivantes à la méthode viewDidLoad à partir de la dernière étape :

 ```objective-c
 [self.resolver interactiveLogonWithCallback:^(ADAuthenticationResult *result) {
     if (result.status == AD_SUCCEEDED) {
         [self.resolver.logger logMessage:@"Connected." withLevel:LOG_LEVEL_INFO];
     } else {
         [self.resolver.logger logMessage:@"Authentication failed." withLevel:LOG_LEVEL_ERROR];
     }
 }];
 ```

6. Vous pouvez désormais utiliser le client API en toute sécurité.

[Using Cocoapods]: https://guides.cocoapods.org/using/using-cocoapods.html
[MSDN Add Common Consent]: https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually

## Exemples
- [Office 365-iOS-Connect] : démarrage et authentification <br />
- [O365-iOS-extraits] : demandes et réponses API

[O365-iOS-Connect]: https://github.com/OfficeDev/O365-iOS-Connect
[O365-iOS-Snippets]: https://github.com/OfficeDev/O365-iOS-Snippets

## Contribution
Vous devrez signer un [Contrat de licence de contributeur](https://cla.microsoft.com/) avant d’envoyer votre requête de tirage. Pour compléter le contrat de licence de contributeur (CLA), vous devez envoyer une requête en remplissant le formulaire, puis signer électroniquement le contrat de licence de contributeur quand vous recevrez le courrier électronique contenant le lien vers le document.

Ce projet a adopté le [Code de conduite Open Source de Microsoft](https://opensource.microsoft.com/codeofconduct/). Pour en savoir plus, reportez-vous à la [FAQ relative au code de conduite](https://opensource.microsoft.com/codeofconduct/faq/) ou contactez [opencode@microsoft.com](mailto:opencode@microsoft.com) pour toute question ou tout commentaire.

## Licence
Copyright (c) Microsoft Corporation. Tous droits réservés. Sous licence Apache, version 2,0.
