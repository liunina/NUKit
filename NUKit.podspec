Pod::Spec.new do |s|
  s.name             = 'NUKit'
  s.version          = '0.1.9'
  s.summary          = 'A short description of NUKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://nas.iliunian.com:88/Apple/NUKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'i19850511@gmail.com' => 'i19850511@gmail.com' }
  s.source           = { :git => 'http://nas.iliunian.com:88/Apple/NUKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.3'
  s.platform = 'ios'
  
  s.subspec 'Core' do |core|
	  core.frameworks = 'UIKit'
	  core.dependency 'Masonry'
	  core.dependency 'HBDNavigationBar'
	  core.dependency 'NUBlocksKit'
	  core.public_header_files = 'NUKit/Classes/Core/*.h'
	  core.source_files = 'NUKit/Classes/Core/**/*'
	  # s.resource_bundles = {
	   #   'NUKit' => ['NUKit/Assets/*.png']
	   # }
  end
 
  s.subspec 'ViewModel' do |vm|
	  vm.source_files = 'NUKit/Classes/ViewModel/**/*'
  end
  s.subspec 'Category' do |cg|
	   cg.dependency 'NUKit/Core'
	   cg.source_files = 'NUKit/Classes/Category/**/*'
   end
   s.subspec 'VCCategory' do |cg|
		cg.frameworks = 'SystemConfiguration','AssetsLibrary','Photos','AVFoundation'
		cg.dependency 'NUKit/Core'
		cg.dependency 'NUKit/Category'
		cg.dependency 'Reachability'
		cg.dependency 'TZImagePickerController'
		cg.source_files = 'NUKit/Classes/VCCategory/**/*'
	end
end
