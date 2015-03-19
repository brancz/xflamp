Gem::Specification.new do |s|
  s.name        = 'xflamp'
  s.version     = '0.0.1'
  s.description = 'Daemon for checking build status on travis ci and turning on a real life light bulb if not passing.'
  s.homepage    = 'https://github.com/flower-pot/xflamp'
  s.summary     = 'Extreme Feedback Lamp'
  s.license     = 'MIT'
  s.executables = ['xflamp']
  s.authors     = 'Frederic Branczyk'
  s.email       = 'fbranczyk@gmail.com'

  s.add_runtime_dependency 'bundler'
  s.add_runtime_dependency 'travis'
  s.add_runtime_dependency 'wiringpi'
  s.add_runtime_dependency 'inquirer'
end

