require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe URICompiler do 
  describe '#compile_uri_string' do
    it 'compiles a proper sound-by-id uri' do
      URICompiler.new(Freesound.config.api_key, {:sound_id => 12, :format => :json}).uri.should ==
        URI.parse("http://www.freesound.org/api/sounds/12/?api_key=#{Freesound.config.api_key}&format=json")
    end

    it 'compiles a proper search uri' do
      URICompiler.new(Freesound.config.api_key, {:search => {:q => 'bass', :p => 2}, :format => :json}).uri.should ==
        URI.parse("http://www.freesound.org/api/sounds/search/?api_key=#{Freesound.config.api_key}&format=json&q=bass&p=2")
    end

    it 'adds non-default format parameter' do
      URICompiler.new(Freesound.config.api_key, {:format => :xml, :sound_id => 12}).uri.should ==
        URI.parse("http://www.freesound.org/api/sounds/12/?api_key=#{Freesound.config.api_key}&format=xml")
    end
  end
end

