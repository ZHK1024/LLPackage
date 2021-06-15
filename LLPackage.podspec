#
# Be sure to run `pod lib lint LLPackage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LLPackage'
  s.version          = '1.0.2'
  s.summary          = '服务器资源包同步工具.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ZHK1024/LLPackage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ZHK1024' => 'ZHK1024@foxmail.com' }
  s.source           = { :git => 'https://github.com/ZHK1024/LLPackage.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.swift_version = '5.0'

  s.ios.deployment_target = '11.0'

  s.source_files = 'LLPackage/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'LLPackage' => ['LLPackage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.subspec 'Core' do |core|
      core.source_files = 'LLPackage/Classes/Core/*'
  end
  
  s.subspec 'Zip' do |zip|
      zip.source_files = 'LLPackage/Classes/Zip/*'
      zip.dependency 'SSZipArchive', '>= 2.2.3'
      zip.xcconfig = {
          "OTHER_SWIFT_FLAGS" => '-D LLPACK_ZIP_CONTAINS'
      }
  end
  
  s.default_subspec = 'Core'
 
end
