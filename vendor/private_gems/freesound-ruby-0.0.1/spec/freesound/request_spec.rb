require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Request do
  subject { Request.new(Freesound.config.api_key, {:sound_id => 10}) }

  it 'initializes with a params hash' do
    subject.params.should == {:sound_id => 10}
  end

  it 'fails with invalid format' do
    expect { Request.new(Freesound.config.api_key, {:format => :pdf}) }.to raise_error(InvalidRequestFormatError)
  end

  describe '#get!' do
    it 'returns a Response' do
      subject.get!.should be_a(Response)
    end

    it 'fails with invalid api key' do
      req = Request.new("invalidapikey", {:sound_id => 10})
      expect { req.get! }.to raise_error(InvalidApiKeyError)
    end
  end
end
