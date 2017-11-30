#
#  Be sure to run `pod spec lint YBBaseFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "YBBaseFramework"
s.version      = "1.0.2"
s.summary      = "base framework settings for ubank project."

s.description  = <<-DESC
It is a base framework settings for ubank project. written by Object-C.
DESC

s.homepage     = "https://github.com/asance/YBBaseFramework"
s.license      = "MIT"
s.author             = { "asance" => "lidongwc@126.com" }

s.platform     = :ios
s.ios.deployment_target = "8.0"
s.source       = { :git => "https://github.com/asance/YBBaseFramework.git", :tag => "v#{s.version}" }
s.source_files  =  "YBBaseFrameworkDemo/YBBaseFrameworkDemo/YBBaseFramework/**/*.{h,m}"
s.resources = "YBBaseFrameworkDemo/YBBaseFrameworkDemo/Resources/*.png"
s.frameworks = "UIKit", "CoreGraphics", "Foundation", "CommonCrypto", "objc"
s.dependency 'YBBaseDefine', '~>1.0.1'
s.dependency 'YBBaseCategory', '~>1.0.1'
s.dependency 'YBKeychainManager', '~>1.0.1'
s.dependency 'YBLoginWindowManager', '~>1.0.1'
s.dependency 'AFNetworking', '~>3.1.0'
s.dependency 'SVProgressHUD', '~>2.1.2'
s.requires_arc = true

end
