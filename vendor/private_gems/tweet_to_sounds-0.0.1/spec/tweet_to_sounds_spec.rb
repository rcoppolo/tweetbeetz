require "spec_helper"

describe TweetToSounds do
  describe ".sounds_for_tweet" do
    it "should return sound urls for a tweet" do
      tweet  = "Old technology, old procedures, old policies, old methods, " \
                 "or; Often produces"

      sounds = VCR.use_cassette("integration", record: :new_episodes) do
        TweetToSounds.sounds_for_tweet(tweet)
      end

      sounds.length.must_equal TweetToSounds.number_of_sounds

      sounds.each do |sound|
        sound.must_match /http/
      end
    end
  end
end
