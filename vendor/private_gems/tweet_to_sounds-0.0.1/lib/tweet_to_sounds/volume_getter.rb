module TweetToSounds
  class VolumeGetter
    def initialize(sounds)
      @sounds = sounds
    end

    def get_volumes
      volumes = []
      key = TweetToSounds.freesound_api_key
      threads = @sounds.map do |sound|
        Thread.new(sound) do |s|
          Thread.current[:results] = \
            Net::HTTP.get(URI("http://www.freesound.org/api/sounds/#{sound.id}/analysis/lowlevel/average_loudness/?api_key=#{key}")).to_f.round(2)
        end 
      end
      volumes = threads.flat_map { |t| t.join; t[:results] }
    end
  end
end
