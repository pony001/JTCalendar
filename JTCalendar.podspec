Pod::Spec.new do |s|
  s.name         = "PJTCalendar"
  s.version      = "1.2.3"
  s.summary      = "A customizable calendar view for iOS."
  s.homepage     = "https://github.com/pony001/JTCalendar"
  s.license      = { :type => 'MIT' }
  s.author       = { "Jonathan Tribouharet" => "jonathan.tribouharet@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/pony001/JTCalendar.git", :commit => "89a70df933533588bd19f8dcfb737de831e1956c"}
  s.source_files  = 'JTCalendar/*'
  s.requires_arc = true
  s.screenshots   = ["https://raw.githubusercontent.com/jonathantribouharet/JTCalendar/master/Screens/example.gif"]
end
