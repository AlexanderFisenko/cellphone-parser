$(document).ready ->

  setDropDownWidth = () ->
    width = $('#device-search-input').width()
    $('.tt-dataset').width(width)

  $(document).on 'click', '#show-results-btn', (e) ->
    query = $('#search-input').val()
    if query.length > 0
      sendSearchForm(query)
    return false

  sendSearchForm = (query) ->
    $.ajax
      url: '/devices'
      data: { query: query }
      dataType: 'script'

  $(document).on 'click', '.device-show-link', (e) ->
    e.preventDefault()
    $('body, html').animate({ scrollTop: 0 }, 800)
    deviceId = $(this).data('id')
    sendShowDevice(deviceId)

  $(document).on 'click', '.tt-suggestion', (e) ->
    e.preventDefault()
    $('body, html').animate({ scrollTop: 0 }, 800)
    deviceId = $(this).children('a').data('id')
    sendShowDevice(deviceId)

  sendShowDevice = (deviceId) ->
    $.ajax
      url: '/devices/' + deviceId
      dataType: 'html'

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
