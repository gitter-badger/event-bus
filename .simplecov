begin
  require 'coveralls'
rescue LoadError
  puts 'Failed to load coveralls. That might happen on ruby < 1.9.3'
end

SimpleCov.start do
  add_filter "/features/"
  add_filter "/spec/"
  add_filter "/tmp"
  add_filter "/vendor"
  
  add_group "lib", "lib"
end
