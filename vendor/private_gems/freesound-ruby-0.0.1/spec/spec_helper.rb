$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'freesound'
require 'webmock/rspec'

include Freesound

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before do
    Freesound.config.api_key = ENV['FREESOUND_KEY'] || fail("Register your app at freesound.org and store your key in the $FREESOUND_KEY variable.")

    @sound_json  = File.read("#{Freesound.root_dir}/data/sample.json") 
    @sound_xml   = File.read("#{Freesound.root_dir}/data/sample.xml") 
    @sound_yaml  = File.read("#{Freesound.root_dir}/data/sample.yaml") 
    @search_json = File.read("#{Freesound.root_dir}/data/sample_query.json") 
    @error_json = File.read("#{Freesound.root_dir}/data/auth_error.json") 

    @json_url   = "http://www.freesound.org/api/sounds/10/?api_key=#{Freesound.config.api_key}&format=json"
    @xml_url    = "http://www.freesound.org/api/sounds/10/?api_key=#{Freesound.config.api_key}&format=xml"
    @yaml_url   = "http://www.freesound.org/api/sounds/10/?api_key=#{Freesound.config.api_key}&format=yaml"
    @search_url = "http://www.freesound.org/api/sounds/search/?api_key=#{Freesound.config.api_key}&format=yaml"
    @search_url = "http://www.freesound.org/api/sounds/search/?api_key=#{Freesound.config.api_key}&format=json&q=badass"
    @error_url = "http://www.freesound.org/api/sounds/10/?api_key=invalidapikey&format=json"

    # use web mock to stub http requests
    stub_request(:get, @json_url).to_return(:body => @sound_json)
    stub_request(:get, @xml_url).to_return(:body => @sound_xml)
    stub_request(:get, @yaml_url).to_return(:body => @sound_yaml)
    stub_request(:get, @search_url).to_return(:body => @search_json)
    stub_request(:get, @error_url).to_return(:body => @error_json)
  end
end
