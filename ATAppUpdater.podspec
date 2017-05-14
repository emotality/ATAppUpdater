Pod::Spec.new do |s|
  s.name        = "ATAppUpdater"
  s.version     = "2.0"
  s.summary     = "Checks if there is a newer version of your app in the AppStore and alerts the user to update."
  s.screenshots = "https://www.emotality.com/development/GitHub/ATAppUpdater-1.png", "https://www.emotality.com/development/GitHub/ATAppUpdater-2.png", "https://www.emotality.com/development/GitHub/ATAppUpdater-3.png"
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author              = { "Jean-Pierre Fourie" => "jp@emotality.com" }
  s.homepage		= 'https://github.com/emotality/ATAppUpdater'
  s.social_media_url    = 'https://twitter.com/emotality'

  s.platform                = :ios
  s.ios.deployment_target   = '8.0'
  s.requires_arc            = true

  s.source              = { :git => "https://github.com/emotality/ATAppUpdater.git", :tag => s.version.to_s }
  s.source_files        = 'ATAppUpdater/*.{m,h}'
  s.public_header_files = 'ATAppUpdater/*.h'
  s.frameworks          = 'UIKit', 'SystemConfiguration'
end
