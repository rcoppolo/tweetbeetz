require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe String do
  describe '#numberize' do
    it 'converts to an integer' do
      '123'.numberize.should == 123
    end

    it 'converts to a float' do
      '123.456'.numberize.should == 123.456
    end

    it 'returns nil for non-numerical strings' do
      'abc123'.numberize.should be_nil
    end
  end

  describe '#numberizeable?' do
    it 'returns true' do
      %w{ 123 -2 1.23 -1.56 .900 23. 023 }.each { |str| str.should be_numberizeable }
    end

    it 'returns false' do
      %w{ 1.2.3 12a3 alex 1-23 --345 ..45 98..}.each { |str| str.should_not be_numberizeable }
    end
  end

  describe '#fs_underscore' do
    it 'underscores -s' do
      'one-two'.fs_underscore.should == 'one_two'
    end

    it 'underscores whitespace' do
      'one two'.fs_underscore.should == 'one_two'
    end
  end
end
