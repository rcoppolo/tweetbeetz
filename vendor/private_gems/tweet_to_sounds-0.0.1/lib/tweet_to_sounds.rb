require "freesound"
require "tweet_to_sounds/freesound_ext"

require "tweet_to_sounds/version"
require "tweet_to_sounds/keyword_extractor"
require "tweet_to_sounds/sound_finder"
require "tweet_to_sounds/volume_getter"

module TweetToSounds
  class << self
    def sounds_for_tweet(tweet)
      keywords = KeywordExtractor.new(tweet).keywords
      sounds   = SoundFinder.new(keywords).urls
      urls     = sounds.map(&:preview_hq_mp3)

      urls
    end

    def sounds_for_tweet_with_volumes(tweet)
      keywords = KeywordExtractor.new(tweet).keywords
      sounds   = SoundFinder.new(keywords).sounds
      urls     = sounds.map(&:preview_hq_mp3)
      volumes  = VolumeGetter.new(sounds).get_volumes

      urls.zip(volumes)
    end

    def freesound
      @freesound ||= Freesound::Client.new(freesound_api_key)
    end

    def freesound_api_key
      "f21ede7f1694428ab829e72f52e3d2df"
    end

    attr_writer :number_of_sounds

    def number_of_sounds
      @number_of_sounds ||= 5
    end
  end
end
