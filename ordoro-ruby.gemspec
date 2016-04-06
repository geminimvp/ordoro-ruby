# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ordoro/version'

Gem::Specification.new do |gem|
  gem.name          = "ordoro-ruby"
  gem.version       = Ordoro::VERSION
  gem.summary       = %q{TODO: Summary}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = ["James Kane"]
  gem.email         = "fastjames@gmail.com"
  gem.homepage      = "https://github.com/geminimvp/ordoro-ruby"

  gem.files         = `git ls-files`.split($/)

  `git submodule --quiet foreach --recursive pwd`.split($/).each do |submodule|
    submodule.sub!("#{Dir.pwd}/",'')

    Dir.chdir(submodule) do
      `git ls-files`.split($/).map do |subpath|
        gem.files << File.join(submodule,subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'dotenv'
  gem.add_development_dependency 'rake', '~> 11.0'
  gem.add_development_dependency 'rdoc', '~> 4.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'

  gem.add_dependency 'httparty', '~> 0.13.7'
  gem.add_dependency 'virtus'
  gem.add_dependency 'activesupport'

end
