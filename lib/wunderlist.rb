require 'uri'

module Wunderlist
  include ActiveSupport::Configurable

  def self.uri name, rel
    # name should be a Hash, or:
    if name.is_a?(Class) || name.is_a?(Module)
      name = name.name.underscore.to_sym
    end

    if !self.config.respond_to?(name)
      raise Exception.new("namespace '#{name}' not configured. Check config in routes.rb")
    end

    links = config.send(name)
    unless links.present? && links.include?(rel)
      raise Exception.new("rel '#{rel}' not in configured in hash #{name}. Check config in routes.rb")
    end
    URI::join(Application.config.public_url, links[rel]).to_s
  end
end
