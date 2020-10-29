#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint scan.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_dong_scan'
  s.version          = '0.0.4'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  s.resources = "Classes/SDScanResource.bundle"

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'

end
