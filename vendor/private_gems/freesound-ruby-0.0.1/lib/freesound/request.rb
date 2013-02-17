module Freesound
  class InvalidRequestFormatError < ArgumentError; end
  class InvalidApiKeyError < ArgumentError; end

  class Request
    attr_reader :uri, :uri_compiler, :params, :response, :format, :api_key

    def initialize(api_key, params={})
      self.format = params[:format] || :json
      @api_key = api_key
      @params = params
      @response = nil
    end

    def format=(form)
      raise(InvalidRequestFormatError, "#{form} is not a valid request format") unless [:json, :xml, :yaml, :yml].include?(form.to_sym)
      @format = form.to_sym
    end

    def uri_compiler
      @uri_compiler ||= URICompiler.new(@api_key, @params.dup.merge({:format => @format}))
    end

    def uri
      @uri ||= self.uri_compiler.uri
    end

    def get!
      response_body = Net::HTTP.get_response(self.uri).body
      @response ||= Response.new(response_body, @format)

      raise(InvalidApiKeyError, "#{@api_key} is not a valid API key") if @response.errors[:error]
      @response
    end
  end
end
