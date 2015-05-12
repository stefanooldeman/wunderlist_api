# vi:ft=ruby

# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^app/models/(.+)\.rb$})              { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/resources/(.+)_resource\.rb$})  { |m| ["spec/acceptance/#{m[1]}_spec.rb"] }
  watch("app/resources/base_resource.rb")       { "spec/acceptance" }
  watch(%r{^app/views/(.+)_representer\.rb$})   { |m| ["spec/acceptance/#{m[1]}_spec.rb"] }
end
