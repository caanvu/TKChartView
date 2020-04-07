#
#  Be sure to run `pod spec lint TKChartView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "TKChartView"
  spec.version      = "0.1.0"
  spec.swift_version = "5.0"
  spec.summary      = "A simple bar chart view."

  spec.homepage     = "https://github.com/caanvu/TKChartView"
  spec.license      = "MIT"

  spec.author             = { "caanvu" => "caanvu@qq.com" }
  
  spec.ios.deployment_target = "10.0"

  spec.source       = { :git => "https://github.com/caanvu/TKChartView.git", :tag => spec.version }

  spec.source_files  = "Source/**/*.swift"
  spec.framework  = "UIKit"
  spec.requires_arc = true

end
