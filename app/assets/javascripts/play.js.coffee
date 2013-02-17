$ ->
  $('.tweet').on('click', '.play', (e) ->
    e.preventDefault()
    link = $(this)
    link.text('Loading...')
    $.post("/sounds", { id: $(this).data('id') }, (data) ->
      playAll(data)
      link.text('Play')
    )
  )
