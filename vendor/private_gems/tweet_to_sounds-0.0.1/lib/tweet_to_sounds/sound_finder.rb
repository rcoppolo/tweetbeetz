module TweetToSounds
  class SoundFinder
    def initialize(keywords)
      @keywords = keywords
    end

    def sounds
      @sounds ||= begin
        keywords = pick_keywords(@keywords)
        threads = keywords.map do |keyword|
          Thread.new(keyword) do |kw|
            Thread.current[:results] = \
              pick_results TweetToSounds.freesound.advanced_search(kw)
          end
        end
        results = threads.flat_map { |t| t.join; t[:results] }
        stable_sample results, TweetToSounds.number_of_sounds
      end
    end

    protected

    def pick_keywords(keywords)
      stable_sample keywords, 5
    end

    # TODO: be smarter
    def pick_results(sounds)
      stable_sample sounds, 3
    end

    def stable_sample(array, num_elements)
      result   = []
      num_left = num_elements
      length   = array.length

      array.each_with_index do |el, index|
        threshold = [1.0, (num_left.to_f / (length - index))].min
        if Kernel.rand <= threshold
          result << el
          num_left -= 1
        end
      end

      result
    end
  end
end
