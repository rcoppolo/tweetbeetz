var playCallback = "staggered";

var playAll = function (urls_with_volumes) {
  var loaded = 0;
  var urls = [];
  var volumes = [];
  for (var i = 0; i < urls_with_volumes.length; i++) {
    urls.push(urls_with_volumes[i][0]);
    volumes.push(parseFloat(urls_with_volumes[i][1]));
  };


  var adjustVolumes = function(raw_volumes) {
    var max, min, diff_max, diff_min, boost;
    var volumes = [];
    raw_volumes[0] = 0.02;
    max = Math.max.apply(Math, raw_volumes);
    min = Math.min.apply(Math, raw_volumes);
    boost = 1 - max;
    if (min < 0.1) return raw_volumes;
    for (var i = 0; i < raw_volumes.length; i++) {
      diff_max = max - raw_volumes[i];
      diff_min = min - raw_volumes[i];
      volumes.push(raw_volumes[i] + diff_max + diff_min + boost);
    };

    return volumes;
  };

  var adjusted_volumes = adjustVolumes(volumes);

  var main = function () {
    createjs.Sound.addEventListener("loadComplete", loadHandler);

    for (var i = 0; i < urls.length; i++) {
      if (createjs.Sound.preloadHash[urls[i]]) {
        loadHandler();
      } else {
        createjs.Sound.registerSound(urls[i], urls[i]);
      }
    }
  };

 
  var loadHandler = function () {
    loaded++;

    if (loaded == urls.length) {
      createjs.Sound.removeEventListener("loadComplete", loadHandler);
      strategies[playCallback]();
    }
  };

  var strategies = {
    simultaneous: function () {
      for (var i = 0; i < urls.length; i++) {
        var instance = createjs.Sound.play(urls[i]);
        instance.setVolume(adjusted_volumes[i]);
      }
    },

    series: function () {
      var i = 0;

      var playNext = function () {
        if (!urls[i]) return;

        var instance = createjs.Sound.play(urls[i]);
        instance.setVolume(adjusted_volumes[i]);
        instance.addEventListener("complete", playNext);

        i++;
      }

      playNext();
    },

    staggered: function () {
      var i = 0;

      var playNext = function () {
        if (!urls[i]) return;

        var instance = createjs.Sound.play(urls[i]);
        instance.setVolume(adjusted_volumes[i]);
        setTimeout(playNext, 500);

        i++;
      }

      playNext();
    }
  }

  main();
}
