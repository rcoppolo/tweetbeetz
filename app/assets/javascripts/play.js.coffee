$ ->
  $('.tweet').on('click', '.play', (e) ->
    e.preventDefault()
    link = $(this)
    link.html('<img class="loader" src="/assets/load.gif" />')
    $.post("/sounds", { id: $(this).data('id') }, (data) ->
      playAll(data)
      link.html('<img src="/assets/play.png" />')
    )
  )

  $('.tweet .play').click()

  $('.get_another_tweet').on 'click', (e) ->
    e.preventDefault()
    document.location = '/' + $('input[name=username]').val()
