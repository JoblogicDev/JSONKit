Pod::Spec.new do |s|
  s.name             = 'JoblogicJSONKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of JoblogicJSONKit.'
  s.description      = <<-DESC
  A longer description of YourLibraryName in Markdown format.
  DESC
  s.homepage         = 'https://joblogicltd.visualstudio.com/JobLogic%20Mobile/_git/joblogic-mobile-ios-library-jsonkit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'duyb@joblogic.com' }
  s.source           = { :git => 'https://joblogicltd.visualstudio.com/JobLogic%20Mobile/_git/joblogic-mobile-ios-library-jsonkit', :tag => 'v1.0.0' }
  s.platform         = :ios, '13.0'
  s.source_files     = 'JSONKit/**/*.{h,m}'
  s.requires_arc = false
end
