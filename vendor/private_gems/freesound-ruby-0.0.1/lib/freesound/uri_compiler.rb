module Freesound
  class Freesound::URICompiler
    attr_reader :uri_string

    def initialize(api_key, params)
      search_params = params.delete(:search)
      sound_id      = params.delete(:sound_id)
      form          = params.delete(:format)
      @api_key      = api_key
      @uri_string   = compile_uri_string(search_params, sound_id, form)
    end

    def uri
      @uri ||= URI.parse(@uri_string)
    end

    def compile_uri_string(search_params, sound_id, form)
      format_string = form ? "&format=#{form}" : ""

      if search_params
        search_uri(search_params, format_string)
      elsif sound_id
        sound_id_uri(sound_id, format_string)
      end
    end

    private

    def search_uri(search_params, format_string)
      "#{Freesound.config.sounds_url}/search/?#{api_key_string}#{format_string}&#{search_params.to_uri}"
    end

    def sound_id_uri(id, format_string)
      "#{Freesound.config.sounds_url}/#{id}/?#{api_key_string}#{format_string}"
    end

    def api_key_string
      @api_key.empty? ? "" : "api_key=#{@api_key}"
    end
  end
end
