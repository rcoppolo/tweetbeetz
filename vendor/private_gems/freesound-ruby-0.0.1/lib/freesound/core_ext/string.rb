class String
  def numberize
    if numberizeable?
      float? ? to_f : to_i
    end
  end

  def numberizeable?
    !scan(/^\-?\d*\.?\d*$/).empty?
  end

  def fs_underscore
    gsub(/\W/, '_')
  end

  private

  def float?
    scan(/\./).size == 1
  end
end
