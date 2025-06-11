Pod::Spec.new do |s|
  s.name             = 'impulse_player_flutter'
  s.version          = '0.3.3'
  s.summary          = 'Impulse Player flutter plugin'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://getimpulse.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Webuildapps' => 'info@webuildapps.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'impulse_player_ios'#, '= 0.3.1' # Here for reference, Cocoapods doesn't support defining the version here if it's hosted via GitHub.
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
