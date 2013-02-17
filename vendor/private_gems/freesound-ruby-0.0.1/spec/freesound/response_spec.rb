require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Response do
  it 'takes a raw hash' do
    Response.new('{"id": 3}', :json).data.should == {:id => 3}
  end

  context 'with invalid api key' do
    before { @error = Response.new(@error_json) }

    it 'contains error information' do
      @error.errors[:status_code].should == 401
      @error.errors[:explanation].should == "Please include your api key as the api_key GET parameter"
      @error.errors[:type].should        == "AuthenticationError"
      @error.errors[:error].should       == true
    end
  end

  context 'with valid api key' do
    before do
      @single   = Response.new(@sound_json)
      @multiple = Response.new(@search_json)
    end

    it 'has no errors' do
      @single.errors.should == {}
      @multiple.errors.should == {}
    end

    it 'has sounds' do
      @single.sounds.first.should be_a(Sound)
      @multiple.sounds.first.should be_a(Sound)
    end

    it 'has number of results' do
      @single.num_results.should == 1
      @multiple.num_results.should == 12
    end
  end
end
