Pod::Spec.new do |s|
  s.name             = 'NUKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NUKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitea.iliunian.com/apple/NUKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'i19850511@gmail.com' => 'i19850511@gmail.com' }
  s.source           = { :git => 'https://gitea.iliunian.com/apple/NUKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'
  
  s.public_header_files = 'NUKit/Classes/*.h'
  s.source_files = 'NUKit/Classes/*.{h,m}'
  s.frameworks = 'UIKit','AssetsLibrary','Photos','AVFoundation'

  s.dependency 'HBDNavigationBar'
  # s.resource_bundles = {
  #   'NUKit' => ['NUKit/Assets/*.png']
  # }
  s.subspec 'Category' do |cg|
	  cg.dependency 'Masonry'
	  cg.dependency 'BlocksKit'
	  cg.dependency 'AFNetworking/Reachability'
	  cg.dependency 'TZImagePickerController'
	  cg.source_files = 'NUKit/Classes/Category/**/*'
  end
end
