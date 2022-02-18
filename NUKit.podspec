Pod::Spec.new do |s|
  s.name             = 'NUKit'
  s.version          = '0.2.2'
  s.summary          = 'A short description of NUKit.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
AA
                       DESC

  s.homepage         = 'https://github.com/liunina/NUKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'i19850511@gmail.com' => 'i19850511@gmail.com' }
  s.source           = { :git => 'https://github.com/liunina/NUKit.git', :tag => s.version.to_s }
  s.platform = 'ios'
  s.ios.deployment_target = '10.0'
  s.subspec 'Core' do |core|
	  core.frameworks = 'UIKit'
	  core.dependency 'Masonry'
	  core.dependency 'HBDNavigationBar'
	  core.dependency 'NUBlocksKit', '~> 2.0.0'
	  core.public_header_files = 'NUKit/Classes/Core/*.h'
	  core.source_files = 'NUKit/Classes/Core/**/*'
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
