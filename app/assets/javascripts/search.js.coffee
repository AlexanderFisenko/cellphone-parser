$(document).ready ->

  setDropDownWidth = () ->
    width = $('#device-search-input').width()
    $('.tt-dataset').width(width)

  emptySections = () ->
    $('.search-results').empty()
    $('.show-device').empty()

  $(document).on 'click', '#show-results-btn', (e) ->
    query = $('#search-input').val()
    if query.length > 0
      sendSearchForm(query)
    return false

  sendSearchForm = (query) ->
    $.ajax
      url: '/search'
      data: { query: query }
      dataType: 'html'
      success: (response) ->
        emptySections()
        $('.search-results').html(response)
      error: (xhr, status, error) ->
        console.error "#{status} --> #{error}"

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
      url: '/show_device'
      data: { device_id: deviceId }
      dataType: 'html'
      success: (response) ->
        emptySections()
        $('.show-device').html(response)
      error: (xhr, status, error) ->
        console.error "#{status} --> #{error}"

  source = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: "/search?query=%QUERY&typeahead=true"
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
