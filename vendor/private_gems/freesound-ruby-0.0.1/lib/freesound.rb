require 'net/http'
require 'uri'
require 'crack'

YAML::ENGINE.yamler = 'syck'

module Freesound

  require 'freesound/core_ext/hash'
  require 'freesound/core_ext/string'
  require 'freesound/version'
  require 'freesound/client'
  require 'freesound/request'
  require 'freesound/uri_compiler'
  require 'freesound/response'
  require 'freesound/response_parser'
  require 'freesound/sound'

  def self.root_dir
    File.expand_path('..', File.dirname(__FILE__))
  end

  module Configuration
    DEFAULTS = {
      :api_key    => nil,
      :base_url   => 'http://www.freesound.org/api',
      :sounds_url => 'http://www.freesound.org/api/sounds'
    }

    DEFAULTS.each_key do |key|
      eval <<-EOS
        def self.#{key}
          @@#{key} ||= DEFAULTS[:#{key}]
        end

        def self.#{key}=(val)
          @@#{key} = val
        end
      EOS
    end

    class InvalidConfigurationParameterError < ArgumentError; end

    def self.method_missing(name, *args)
      raise(InvalidConfigurationParameterError, "#{name} is not a recognized configuration parameter")
    end
  end # module Configuration

  def self.configure(params={})
    params.each do |key, value|
      Configuration.send("#{key}=", value)
    end

    yield Configuration if block_given?
  end

  def self.config
    Configuration
  end
end # module Freesound
