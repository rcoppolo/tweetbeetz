# freesound-ruby
[freesound.org](http://www.freesound.org) api wrapper.

### Usage
```ruby
require 'freesound-ruby'

# Initialize a client object with your api key
# (get one at http://www.freesound.org/api/apply)
fc = Freesound::Client.new("yourfreesoundapikey123456789")

# Get a sound by id
sound = fc.get_sound(125)
sound.id              # => 125
sound.bitrate         # => 1411
sound.waveform_l      # => "http://www.freesound.org/data/displays/0/125_23_wave_L.png"

# Search for a sound
sounds = fc.search_sounds("badass")
sounds.first.tags     # => ["prison", "jail", "door", "closing", "close", "cinematic", "cell", "boom"],
```

### More to come!
