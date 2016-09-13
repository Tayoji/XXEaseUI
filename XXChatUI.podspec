Pod::Spec.new do |s|
s.name         = "XXChatUI"
s.version      = "1.0.1"
s.summary      = "修车人聊天系统"
s.homepage     = "https://github.com/Tayoji/XXEaseUI"
#s.screenshots  = "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/errorScreenshot.png", "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/successScreenshot.png"
s.license      = { :type => "MIT", :file => "LICENCE" }
s.author             = { "Tayoji" => "595521651@qq.com" }
#s.social_media_url   = "http://twitter.com/vikmeup"
s.platform     = :ios
s.ios.deployment_target = '8.0'
s.source       = { :git => "https://github.com/Tayoji/XXEaseUI.git", :tag => s.version }
s.source_files  = "XXEaseUI/ChatUI/EMUIKit/**/*.{h,m,a}"
s.resources     = "XXEaseUI/ChatUI/resources/*"
#s.framework  = 'HyphenateFullSDK'
s.requires_arc = true
s.dependency 'HyphenateFullSDK'
end
