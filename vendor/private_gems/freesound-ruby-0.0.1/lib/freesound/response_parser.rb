module Freesound
  class ResponseParser
    attr_reader :format

    def initialize(form)
      @format = form
    end

    def parse(raw)
      case @format
      when :xml
        parse_xml(raw)
      when :yaml, :yml
        parse_yaml(raw)
      else
        parse_json(raw)
      end
    end

    private

    def parse_json(raw)
      result = ::Crack::JSON.parse(raw)

      if result["sounds"]
        result["sounds"].map { |sound| sound.fs_symbolize_keys }
      else
        result.fs_symbolize_keys
      end
    end

    # xml gets parsed slightly differently than json and yaml.
    # the result needs to convert single element arrays to strings,
    # convert strings like "2" to their corresponding number object i.e. 2
    # and remove the nesting of the :tags key under "resource"
    def parse_xml(raw)
      result = ::Crack::XML.parse(raw)["response"]

      # put necessary changes in a lambda
      fix_sound_hash = lambda do |hash|
        fixed = hash.fs_symbolize_keys.flatten_single_element_array_values.numberize_values
        fixed[:tags] = fixed[:tags][:resource]
        fixed
      end

      if result["sounds"]
        result["sounds"].map do |sound|
          fix_sound_hash.call(sound)
        end
      else
        fix_sound_hash.call(result)
      end
    end

    def parse_yaml(raw)
      result = ::YAML::load(raw)

      if result["sounds"]
        result["sounds"].map { |sound| sound.fs_symbolize_keys }
      else
        result.fs_symbolize_keys
      end
    end
  end
end
