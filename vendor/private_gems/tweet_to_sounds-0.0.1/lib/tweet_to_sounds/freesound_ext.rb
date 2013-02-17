module Freesound
  class Client
    def advanced_search(query)
      request  = Request.new(
                   @api_key,
                   search: {
                     q: query,
                     sounds_per_page: 10,
                     f: "duration:[0%20TO%2010]"
                     #s: "rating_desc"
                   }
                 )
      response = request.get!

      @requests  << request
      @responses << response

      response.sounds
    end
  end

  class Response
    def sounds
      return [] if errors[:error]

      @sounds ||= data.map do |sound|
        result = Sound.new
        sound.each { |k, v| result.send("#{k}=", v) }
        result
      end
    end
  end
end
