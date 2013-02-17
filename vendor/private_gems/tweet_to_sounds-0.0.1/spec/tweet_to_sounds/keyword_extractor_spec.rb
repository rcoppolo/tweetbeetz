require "spec_helper"

module TweetToSounds
  EXAMPLES = {
    "Old technology, old procedures, old policies, old methods, or; Often produces" =>
    ["old", "technology", "procedures", "policies", "methods", "often", "produces"],
    "O N OLD B L A Z N G B L AZ N G B L A Z N G B L A Z N G B L A Z N G B L A Z N G B L A Z N G B L A Z N G B L A Z N G THE THE THE THE THE THE" =>
    ["old"],
    "My 3-second whisper to make" =>
    ["my", "3-second", "whisper", "make"]
  }

  describe KeywordExtractor do
    EXAMPLES.each do |tweet, result|
      it "for tweet: #{tweet}" do
        KeywordExtractor.new(tweet).keywords.must_equal result
      end
    end
  end
end
