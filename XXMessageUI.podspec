Pod::Spec.new do |s|
s.name         = "XXMessageUI"
s.version      = "1.0.5"
s.summary      = "修车人消息界面"
s.homepage     = "https://github.com/Tayoji/XXEaseUI"
#s.screenshots  = "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/errorScreenshot.png", "https://raw.githubusercontent.com/vikmeup/SCPopUpView/master/successScreenshot.png"
s.license      = { :type => "MIT", :file => "LICENCE" }
s.author             = { "Tayoji" => "595521651@qq.com" }
#s.social_media_url   = "http://twitter.com/vikmeup"
s.platform     = :ios
s.ios.deployment_target = '8.0'
s.source       = { :git => "https://github.com/Tayoji/XXEaseUI.git", :tag => s.version }
s.source_files  = 'XXEaseUI/MessageUI/**/*.{swift,h}'
#s.framework  = "QuartzCore"
s.requires_arc = true
end
