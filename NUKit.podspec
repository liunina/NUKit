Pod::Spec.new do |s|
  s.name             = 'NUKit'
  s.version          = '0.1.2'
  s.summary          = 'A short description of NUKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitea.iliunian.com/apple/NUKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'i19850511@gmail.com' => 'i19850511@gmail.com' }
  s.source           = { :git => 'http://nas.iliunian.com:82/apple/NUKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.3'
  s.platform = 'ios'
  
  s.subspec 'Core' do |core|
	  core.frameworks = 'UIKit','AssetsLibrary','Photos','AVFoundation'
	  core.dependency 'Masonry'
	  core.dependency 'HBDNavigationBar'
	  core.dependency 'BlocksKit'
	  core.public_header_files = 'NUKit/Classes/Core/*.h'
	  core.source_files = 'NUKit/Classes/Core/**/*'
	  # s.resource_bundles = {
	   #   'NUKit' => ['NUKit/Assets/*.png']
	   # }
  end
  s.subspec 'Category' do |cg|
	  cg.frameworks = 'SystemConfiguration'
	  cg.dependency 'NUKit/Core'
	  cg.dependency 'Masonry'
	  cg.dependency 'BlocksKit'
	  cg.dependency 'Reachability'
	  cg.dependency 'TZImagePickerController'
	  cg.source_files = 'NUKit/Classes/Category/**/*'
  end
  s.subspec 'ViewModel' do |vm|
	  vm.source_files = 'NUKit/Classes/ViewModel/**/*'
  end
end
