

# /************ 配置说明 ***************/

Pod::Spec.new do |s|

  s.name         = 'mytools'
  s.version      = '0.0.1'
  s.summary      = 'An easy way to send request and upload file'
  s.homepage     = 'https://github.com/ArrQing/mytools'
  s.license      = 'MIT'
  s.author       = { 'YY' => '3297509752@qq.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/ArrQing/mytools.git', :tag => s.version }
  s.source_files = 'YYTool/YYTool/YYToolBase/**/*.{h,m}'

  s.requires_arc = true





# /******** 补充点 你想用的 三方库 ********/
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # s.library   = "iconv"
  # s.vendored_libraries = 'Classes/**.a', 'Classes/**.a'
  # s.resources          = "LPPushService/Images/*.png"


  # s.dependency "JSONKit", "~> 1.4"
  # s.dependency "AFNetworking", "~> 3.2.1"
  # s.frameworks = 'UIKit','Foundation'
 

end



# /************ 版本更新维护 ***************/


# git tag 0.0.1

# git push origin 0.0.1

# pod lib lint mytools.podspec --allow-warnings

# pod trunk push mytools.podspec --allow-warnings



