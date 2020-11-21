#
# Be sure to run `pod lib lint ZYKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYKit'
  s.version          = '0.3.0'
  s.summary          = 'A short description of ZYKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ZYKit是一个强大的框架
                       DESC

  s.homepage         = 'https://github.com/baihouping/ZYKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'baihouping' => '844839320@qq.com' }
  s.source           = { :git => 'https://github.com/baihouping/ZYKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.source_files = 'ZYKit/Classes/baseClass/*','ZYKit/Classes/untils/*'
  
  s.resource_bundles = {
     'ZYKit' => ['ZYKit/Assets/ZYKit.bundle']
   }
    s.subspec 'baseClass' do |st|
    st.source_files = "ZYKit/Classes/baseClass/*.{h,m}"
  end
  
  s.subspec 'untils' do |st|
    st.source_files = "ZYKit/Classes/untils/*.{h,m}"
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
