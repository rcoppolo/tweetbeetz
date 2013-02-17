require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Hash do
  describe '#fs_symbolize_keys' do
    it 'symbolizes keys' do
      {"one" => 1, "two" => 2}.fs_symbolize_keys.should == {:one => 1, :two => 2}
    end

    it 'symbolizes keys to an arbitrary level of nestedness' do
      {"one" => 1, "two" => { "three" => 3, "four" => { "five" => 5}}}.fs_symbolize_keys.should == 
        {:one => 1, :two => { :three => 3, :four => { :five => 5}}}
    end
  end

  describe '#flatten_single_element_array_values' do
    it 'converts values that are single element arrays into just the first element of that array' do
      {"one" => [1], "two_and_three" => [2, 3], "four" => 4}
      .flatten_single_element_array_values.should == {"one" => 1, "two_and_three" => [2, 3], "four" => 4}
    end

    it 'does it for nested hashes' do
      {"one" => [1], :nest => { "two" => [2], "three" => [1,2,3]}, "four" => 4}
      .flatten_single_element_array_values.should == {"one" => 1, :nest => { "two" => 2, "three" => [1,2,3] }, "four" => 4}
    end
  end

  describe '#to_uri' do
    it 'converts hash to a uri string' do
      {"one" => 1, :api_key => "1234"}.to_uri.should == "one=1&api_key=1234"
    end
  end

  describe '#numberize_values' do
    it 'turns all numerical string values to ints or floats' do
      {:one => "1", :one_point_two => "1.2", :negative_three => "-3", :something => "anything"}.numberize_values.should ==
        {:one => 1, :one_point_two => 1.2, :negative_three => -3, :something => "anything"}
    end
  end
end
