require "spec_helper"

module TweetToSounds
  describe SoundFinder do
    it "should return some urls given some keywords" do
      results = VCR.use_cassette("hello world") do
        SoundFinder.new(["hello", "world"]).urls
      end
      results.length.must_be :>, 0
      results.each do |result|
        result.must_match /http/
      end
    end

    describe "#stable_sample" do
      it "should sample evenly and stably" do
        finder  = SoundFinder.new(nil)
        input   = (1..100).to_a
        results = []

        1000.times do
          result = finder.send(:stable_sample, input, 3)
          result.count.must_equal 3
          result.sort.must_equal result
          results.concat result
        end

        results.sort!
        results.group_by { |r| r }.each do |number, occurrences|
          occurrences.length.must_be :>=, 15
          occurrences.length.must_be :<=, 50
        end
      end
    end
  end
end
