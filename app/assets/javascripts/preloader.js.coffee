window.Preloader = {
  constructor: (targetNode) ->
    @targetNode = targetNode

  show: ->
    $('.container').css('opacity', '0')
    $('body').append("<div class='preloader'></div>")

  hide: ->
    $('.preloader').remove()
    $('.container').css('opacity', '1')
}
