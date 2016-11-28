#
#  Be sure to run `pod spec lint SDPickerController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SDPickerController"
  s.version      = "1.0.4"
  s.summary      = "A Very beautiful of SDPickerController."
  s.description  = "this is very good SDPickerControlle,Used in photo album, thin, and some optimization "
  s.homepage     = "http://www.jianshu.com/users/3efefee71c8c/latest_articles"
  s.license          = { :type => "MIT", :file => "LICENSE" }
 
  s.author             = { "zhangwei111" => "18580228790@163.com" }
   s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/IOSzhangwei/SDImagePickerController.git", :tag => "1.0.4" }
  s.source_files  = "SDPickerController/**/*"
  s.resource      = "SDPickerController/Resources/Mytools.bundle"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc=true


end
