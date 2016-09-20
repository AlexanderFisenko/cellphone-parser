class CellphoneDataScrapper
  def initialize(device_id)
    @device_id = device_id
    @url = generate_url
  end

  def scrap
    doc = Nokogiri::HTML(open(@url))
    review_header = doc.css('.review-header')
    specs_list_tables = doc.css('#specs-list table')

    released_at = review_header.css('.specs-brief-accent')[0].content
    dimensions = review_header.css('.specs-brief-accent')[1].content
    system = review_header.css('.specs-brief-accent')[2].content
    memory = review_header.css('.specs-brief-accent')[3].content
    display_size = review_header.css('.help.accented.help-display .accent')[0].content
    resolution = review_header.css('.help.accented.help-display')[0].children.last.content
    camera_photo = review_header.css('.help.accented.help-camera').children[3].content
    camera_video = review_header.css('.help.accented.help-camera').children[4].content
    ram = review_header.css('.help.accented.help-expansion .accent-expansion').text
    chipset = review_header.css('.help.accented.help-expansion').children[4].content
    batary_capacity = review_header.css('.help.accented.help-battery .accent-battery').text
    batary_technology = review_header.css('.help.accented.help-battery').children[4].content


    technology = specs_list_tables[0].css('.tr-hover .nfo').text
    two_g_bands_first_line = specs_list_tables[0].css('.tr-toggle')[0].css('.nfo').text
    two_g_bands_second_line = specs_list_tables[0].css('.tr-toggle')[1].css('.nfo').text
    three_g_bands_first_line = specs_list_tables[0].css('.tr-toggle')[2].css('.nfo').text
    three_g_bands_second_line = specs_list_tables[0].css('.tr-toggle')[3].css('.nfo').text
    four_g_bands = specs_list_tables[0].css('.tr-toggle')[4].css('.nfo').text
    speed = specs_list_tables[0].css('.tr-toggle')[5].css('.nfo').text
    gprs = specs_list_tables[0].css('.tr-toggle')[6].css('.nfo').text
    edge = specs_list_tables[0].css('.tr-toggle')[7].css('.nfo').text





    {
      specs_brief: {
        'Released at' => released_at,
        'Dimensions' => dimensions,
        'System' => system,
        'memory' => memory,
        'display_size' => display_size,
        'resolution' => resolution,
        'camera_photo' => camera_photo,
        'camera_video' => camera_video,
        'ram' => ram,
        'chipset' => chipset,
        'batary_capacity' => batary_capacity,
        'batary_technology' => batary_technology
      },
      specs_detaited: {
        'NETWORK': {
          'Technology' => technology,
          '2G bands' => two_g_bands_first_line,
          'blank 2G bands' => two_g_bands_second_line,
          '3G bands' => three_g_bands_first_line,
          'blank 3G bands' => three_g_bands_second_line,
          '4G bands' => four_g_bands,
          'Speed' => speed,
          'GPRS' => gprs,
          'EDGE' => edge
        }
      }
    }
  end

  private

  def generate_url
    "http://www.gsmarena.com/random-#{@device_id}.php"
  end
end
