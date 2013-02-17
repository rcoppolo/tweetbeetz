require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Freesound do
  describe Configuration do
    it 'has default configuration parameters' do
      Freesound::Configuration.sounds_url.should == "http://www.freesound.org/api/sounds"
    end

    it 'adds configuration parameters' do
      Freesound::Configuration.api_key = '123abc'
      Freesound::Configuration.api_key.should == '123abc'
    end
  end

  describe '.configure' do
    it 'takes parameters hash' do
      Freesound.configure(:api_key => 'test123')
      Freesound::Configuration.api_key.should == 'test123'
    end

    it 'takes a block and sets parameters' do
      Freesound.configure do |config|
        config.api_key  = '123abc'
        config.base_url = 'http://www.example.com'
      end

      Freesound::Configuration.api_key.should == '123abc'
      Freesound::Configuration.base_url.should == 'http://www.example.com'
    end

    it 'does both' do
      Freesound.configure(:api_key => '123') do |config|
        config.base_url = 'test.url.com'
      end

      Freesound::Configuration.api_key.should == '123'
      Freesound::Configuration.base_url.should == 'test.url.com'
    end

    it 'fails with unknown configuration parameters' do
      expect { Freesound.configure(:api_ley => '123') }.to raise_error(Freesound::Configuration::InvalidConfigurationParameterError)
      expect { Freesound.configure { |c| c.api_ley = '123' } }.to raise_error(Freesound::Configuration::InvalidConfigurationParameterError)
    end
  end
end
