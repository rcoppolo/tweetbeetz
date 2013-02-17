var playCallback = "staggered";

var playAll = function (urls) {
  var loaded = 0;

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
        createjs.Sound.play(urls[i]);
      }
    },

    series: function () {
      var i = 0;

      var playNext = function () {
        if (!urls[i]) return;

        var instance = createjs.Sound.play(urls[i]);
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
        setTimeout(playNext, 500);

        i++;
      }

      playNext();
    }
  }

  main();
}
