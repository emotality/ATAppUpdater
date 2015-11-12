Pod::Spec.new do |s|
  s.name        = "ATAppUpdater"
  s.version     = "1.7"
  s.summary     = "Checks if there is a newer version of your app in the AppStore and alerts the user to update."
  s.homepage    = "https://github.com/apptality/ATAppUpdater"
  s.screenshots = "http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater1.png", "http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater2.png", "http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater3.png"
  s.license  = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author              = { "Jean-Pierre Fourie" => "info@apptality.co.za" }
  s.social_media_url    = 'https://www.facebook.com/apptality'

  s.platform                = :ios
  s.ios.deployment_target   = "6.0"
  s.requires_arc            = true

  s.source              = { :git => "https://github.com/apptality/ATAppUpdater.git", :tag => s.version.to_s }
  s.source_files        = 'ATAppUpdater/*.{m,h}'
  s.public_header_files = 'ATAppUpdater/*.h'
  s.frameworks          = 'UIKit', 'SystemConfiguration'
end
