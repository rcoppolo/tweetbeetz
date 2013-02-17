class Hash
  def fs_symbolize_keys
    Hash[ map { |k, v| [k.fs_underscore.to_sym, v.is_a?(Hash) ? v.fs_symbolize_keys : v] } ]
  end

  # converting xml into a hash sometimes gives you things like:
  # { 'element' => ['just_one_value'] }
  # this method converts this to the more useful
  # { 'element' => 'just_one_value' }
  def flatten_single_element_array_values
    Hash[ map do |k, v|
      [k, (v.is_a?(Array) && v.size == 1) ? v[0] : (v.flatten_single_element_array_values rescue v)]
    end ]
  end

  # convert to a uri string
  def to_uri
    map { |k, v| "#{k}=#{v}" }.join("&")
  end

  def numberize_values
    Hash[ map { |k, v| [k, ((v.numberizeable? rescue false) ? v.numberize : v)] } ]
  end
end
