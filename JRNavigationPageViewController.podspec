
Pod::Spec.new do |s|


  s.name         = "JRNavigationPageViewController"
  s.version      = "1.1.1"
  s.summary      = "A simple page controller in navigation bar Tools"
  s.homepage     = "https://github.com/JerryFans/JRNavigationPageViewController.git"
  s.license      = "MIT"
  s.platform     = :ios, '8.0'
  s.author             = { "JerryFans" => "fanjiarong_haohao@163.com" }
  s.source       = {:git => 'https://github.com/JerryFans/JRNavigationPageViewController.git', :tag => s.version}
  s.source_files  = 'JRNavigationPageVCDemo/JRNavigationPageViewController/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'Masonry'

end
