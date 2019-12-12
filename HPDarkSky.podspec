Pod::Spec.new do |s|

  s.name         = "HPDarkSky"
  s.version      = "1.0.6"
  s.summary      = "Cross-platform framework to communicate with the DarkSky JSON API"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.homepage     = "https://github.com/henrik-dmg/HPDarkSky"

  s.author             = { "henrik-dmg" => "henrik@panhans.dev" }
  s.social_media_url   = "https://twitter.com/henrik_dmg"

  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => 'https://github.com/henrik-dmg/HPDarkSky.git', :tag => "1.0.6" }

  s.source_files = "Sources/**/*.swift"
  s.framework = "Foundation"
  s.ios.framework = "UIKit"
  s.watchos.framework = "UIKit"
  s.tvos.framework = "UIKit"
  s.swift_version = "5.1"
  s.requires_arc = true

end
