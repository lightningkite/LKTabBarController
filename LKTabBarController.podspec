#
#  Be sure to run `pod spec lint LKTabBarController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name = "LKTabBarController"
  s.version = "0.1.4"
  s.summary = "A Simple tab bar controller"
  s.description  = <<-DESC
Super simple tab bar controller where the developer creates their own buttons and places a container view which holds the sub view controllers.
  DESC
  s.homepage = "https://github.com/lightningkite/LKTabBarController"
  s.license = 'MIT'
  s.author = { "Abraham Done" => "abraham@lightningkite.com" }
  s.source = { :git => "https://github.com/lightningkite/LKTabBarController.git", :tag => "#{s.version}" }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.dependency 'SnapKit', '~> 0.19'
  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit'

end
