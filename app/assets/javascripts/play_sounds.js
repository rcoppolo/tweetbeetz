var playAll = function (urls) {
  var loaded = 0;

  var main = function () {
    createjs.Sound.addEventListener("loadComplete", loadHandler);

    for (var i = 0; i < urls.length; i++) {
      createjs.Sound.registerSound(urls[i], urls[i]);
    }
  };

  var loadHandler = function (event) {
    loaded++;

    if (loaded == urls.length) {
      createjs.Sound.removeEventListener("loadComplete", loadHandler);
      oneAtATime();
    }
  };

  var allAtOnce = function () {
    for (var i = 0; i < urls.length; i++) {
      createjs.Sound.play(urls[i]);
    }
  };

  var oneAtATime = function () {
    var i = 0;

    var playNext = function () {
      if (!urls[i]) return;

      var instance = createjs.Sound.play(urls[i]);
      instance.addEventListener("complete", playNext);

      i++;
    }

    playNext();
  };

  main();
}
