$(document).ready ->

  window.emptySections = () ->
    $('.search-results').empty()
    $('.show-device').empty()

  setDropDownWidth = () ->
    width = $('#device-search-input').width()
    $('.tt-dataset').width(width)

  $(document).on 'click', '#show-results-btn', (e) ->
    query = $('#search-input').val()
    if query.length > 0
      sendSearchForm(query)
    return false

  sendSearchForm = (query) ->
    window.Preloader.show($('.show-results'))
    $.ajax
      url: '/devices'
      data: { query: query }

  $(document).on 'click', '.device-show-link', (e) ->
    e.preventDefault()
    window.scrollTo(0, 0)
    deviceId = $(this).data('id')
    sendShowDevice(deviceId)

  $(document).on 'click', '.tt-suggestion', (e) ->
    e.preventDefault()
    window.scrollTo(0, 0)
    deviceId = $(this).children('a').data('id')
    sendShowDevice(deviceId)

  sendShowDevice = (deviceId) ->
    window.Preloader.show($('.show-device'))
    $.ajax
      url: '/devices/' + deviceId

  source = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: "/devices?query=%QUERY&typeahead=true"
      wildcard: "%QUERY"
      rateLimitWait: 600

  $('#search-input').typeahead(
    {
      hint: false
      minLength: 3
    },
    {
      displayKey: (item) =>
        item.name
      templates:
        suggestion: (item) =>
          html = "<div class='device'>"
          html += "<a href='#' data-id='#{item.id}'>"
          html += "<img src='#{item.img}' /><span class='name'>#{item.name}"
          html += "</span></div>"
      limit: 12
      source: source.ttAdapter()
    }
  )

  setDropDownWidth()
