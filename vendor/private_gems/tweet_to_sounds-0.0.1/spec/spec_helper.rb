require "minitest/autorun"
require "minitest/pride"
require "mocha/setup"

require "pry"

require "vcr"
require "webmock"

require "tweet_to_sounds"

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr_cassettes"
  c.hook_into :webmock
end
