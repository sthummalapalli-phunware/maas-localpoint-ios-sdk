Pod::Spec.new do |s|
  s.name         = "PWLocalpoint"
  s.version      = "2.6.3"
  s.summary      = "Phunware Location Marketing SDK"
  s.homepage     = "http://phunware.github.io/maas-localpoint-ios-sdk/"
  s.author       = { 'Phunware, Inc.' => 'http://www.phunware.com' }
  s.social_media_url = 'https://twitter.com/Phunware'

  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/phunware/maas-localpoint-ios-sdk.git", :tag => 'v2.6.3' }
  s.license      = { :type => 'Copyright', :text => 'Copyright 2015 by Phunware Inc. All rights reserved.' }

  s.public_header_files = 'Framework/2.6.3/Localpoint.framework/Versions/A/Headers/*.h'
  s.ios.vendored_frameworks = 'Framework/2.6.3/Localpoint.framework'
  s.xcconfig      = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/PWLocalpoint/**"'}
  s.library       = 'sqlite3'
  s.ios.frameworks = 'CoreGraphics', 'CoreLocation'
  s.requires_arc = true
end