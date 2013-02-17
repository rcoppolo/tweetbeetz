module Freesound
  class Response
    attr_reader :content, :parser

    def initialize(raw, form=:json)
      @content = raw
      @format  = form
      @parser  = ResponseParser.new(form)
    end

    def data
      @data ||= @parser.parse(@content)
    end

    def errors
      @errors ||= (self.data[:error] rescue false) ? self.data : {}
    end

    def num_results
      self.data.is_a?(Array) ? self.data.size : 1
    end

    def sounds
      return [] if self.errors[:error]

      @sounds ||= if num_results == 1
                    [ Sound.new(*self.data.values) ]
                  else
                    self.data.map do |sound|
                      result = Sound.new
                      sound.each { |k, v| result.send("#{k}=", v) }
                      result
                    end
                  end
    end
  end
end
