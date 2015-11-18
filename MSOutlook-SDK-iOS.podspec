

Pod::Spec.new do |s|
    s.name         = "MSOutlook-SDK-iOS"
    s.version      = "2.0.0"
    s.summary      = "Client libraries for calling Outlook APIs from iOS apps. (Preview)"
    s.description  = "Client libraries for calling Outlook APIs from iOS apps. (Preview)"
    s.homepage     = "https://github.com/OfficeDev/Outlook-SDK-iOS"
    s.license      = "Apache License, Version 2.0"
    s.author             = { "v-migpe" => "v-migpe@microsoft.com" }
    s.social_media_url   = "http://twitter.com/OpenAtMicrosoft"

    s.platform     = :ios
    s.ios.deployment_target = "8.0"
    s.source       = { :git => "https://github.com/OfficeDev/Outlook-SDK-iOS.git",
                     :tag => "v#{s.version}"
                   }
    s.exclude_files = "**/Build/**/*"
    s.requires_arc = true
    s.source_files = "Fetchers/*.{h,m}","Model/*.{h,m}","MSOutlook.h"

    s.dependency "orc"
    s.dependency 'ADALiOS', '=1.2.4'
    s.dependency 'LiveSDK', '=5.6.1'

end

