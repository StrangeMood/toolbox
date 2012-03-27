Gem::Specification.new do |s|
  s.name        = 'decorator'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Ivan Efremov'
  s.email       = 'st8998@hotmail.com'
  s.summary     = 'Decorator'
  s.description = 'Decorator'

  s.add_dependency('activesupport')

  s.files         = %w[decorator.rb]
  s.require_path  = '.'
end