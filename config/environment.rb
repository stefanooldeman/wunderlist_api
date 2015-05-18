env = ENV['RACK_ENV']
custom_config = YAML.load(ERB.new(File.read("./config/application.yml")).result)[env]

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  custom_config.each do |key, value|
   # FIXME config.send(:define_singleton_method, key, proc { value })
   config.send("#{key}=".to_sym, value)
  end
  config.env = env
end
