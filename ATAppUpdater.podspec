Pod::Spec.new do |s|
  s.name	= "ATAppUpdater"
  s.version	= "1.2"
  s.license	= 'MIT'
  s.summary	= "Checks if there is a newer version of your app in the AppStore and alerts the user to update the app."
  s.homepage	= "https://github.com/emotality/ATAppUpdater"
  s.screenshots	= "http://www.apptality.co.za/images/github/ATAppUpdater1.png", "http://www.apptality.co.za/images/github/ATAppUpdater2.png"

  s.author           = { "Jean-Pierre Fourie" => "info@apptality.co.za" }
  s.social_media_url = 'https://twitter.com/emotality'

  s.platform		= :ios, '7.0'
  s.requires_arc	= true
  s.source		= { :git => "https://github.com/emotality/ATAppUpdater.git", :tag => s.version.to_s }
  s.source_files	= 'ATAppUpdater/*.{m,h}'
  s.public_header_files = 'ATAppUpdater/*.h'
  s.frameworks 		= 'UIKit', 'SystemConfiguration'
end
