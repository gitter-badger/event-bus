source 'https://rubygems.org'

# Use dependencies from gemspec
gemspec

# Debug aruba
group :debug do
  if RUBY_VERSION >= '2' && !RUBY_PLATFORM.include?('java')
    gem 'byebug', '~> 4.0.5', :require => false
    gem 'pry-byebug', '~> 3.1.0', :require => false
  end

  if RUBY_VERSION < '2' && RUBY_VERSION > '1.9' && !RUBY_PLATFORM.include?('java')
    gem 'debugger', '~> 1.6.8', :require => false
    gem 'pry-debugger', '~> 0.2.3', :require => false
  end

  gem 'pry-doc', '~> 0.8.0', :require => false
end

group :development, :test do
  # we use this to demonstrate interactive debugging within our feature tests
  if RUBY_VERSION >= '2'
    gem 'pry', '~> 0.10.1', :require => false
  else
    gem 'pry', '~>0.9.12', :require => false
  end

  gem 'aruba', '~>0.12.0', :require => false

  # Run development tasks
  gem 'rake', '~> 10.4.2', :require => false

  if RUBY_VERSION >= '2.0.0'
    # Lint travis yaml
    gem 'travis-yaml', :require => false

    # Reporting
    gem 'bcat', '~> 0.6.2'
    gem 'kramdown', '~> 1.7.0'
  end

  # Code Coverage
  gem 'simplecov', '~> 0.10', :require => false

  # Test api
  gem 'rspec', '~> 3.4', :require => false
  gem 'fuubar', '~> 2.0.0', :require => false

  # using platform for this make bundler complain about the same gem given
  # twice
  if RUBY_VERSION < '1.9.3'
    gem 'cucumber', '~> 1.3.20', :require => false
  else
    gem 'cucumber', '~> 2.0', :require => false
  end

  if RUBY_VERSION >= '1.9.3'
    # Make aruba compliant to ruby community guide
    gem 'rubocop', '~> 0.32.0', :require => false
  end

  gem 'cucumber-pro', '~> 0.0' if RUBY_VERSION >= '1.9.3'

  if RUBY_VERSION >= '1.9.3'
    # License compliance
    gem 'license_finder', '~> 2.0.4', :require => false
  end

  if RUBY_VERSION >= '1.9.3'
    # Upload documentation
    gem 'relish', '~> 0.7.1', :require => false
    gem 'coveralls', '~> 0.8.10', :require => false
  end

  gem 'minitest', '~> 5.8.0', :require => false
end

platforms :rbx do
  gem 'rubysl', '~> 2.0', :require => false
  gem 'rubinius-developer_tools', :require => false
end
