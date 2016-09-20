class DeviceDataScrapper
  def initialize(device_id)
    @device_id = device_id
  end

  def scrap
    doc = Nokogiri::HTML(open("http://www.gsmarena.com/random-#{@device_id}.php"))
    review_header = doc.css('.review-header')
    specs_list_tables = doc.css('#specs-list table')

    # released_at = review_header.css('.specs-brief-accent')[0].content
    # dimensions = review_header.css('.specs-brief-accent')[1].content
    # system = review_header.css('.specs-brief-accent')[2].content
    # memory = review_header.css('.specs-brief-accent')[3].content
    # display_size = review_header.css('.help.accented.help-display .accent')[0].content
    # resolution = review_header.css('.help.accented.help-display')[0].children.last.content
    # camera_photo = review_header.css('.help.accented.help-camera').children[3].content
    # camera_video = review_header.css('.help.accented.help-camera').children[4].content
    # ram = review_header.css('.help.accented.help-expansion .accent-expansion').text
    # chipset = review_header.css('.help.accented.help-expansion').children[4].content
    # batary_capacity = review_header.css('.help.accented.help-battery .accent-battery').text
    # batary_technology = review_header.css('.help.accented.help-battery').children[4].content


    # technology = specs_list_tables[0].css('.tr-hover .nfo').text
    # two_g_bands_first_line = specs_list_tables[0].css('.tr-toggle')[0].css('.nfo').text
    # two_g_bands_second_line = specs_list_tables[0].css('.tr-toggle')[1].css('.nfo').text
    # three_g_bands_first_line = specs_list_tables[0].css('.tr-toggle')[2].css('.nfo').text
    # three_g_bands_second_line = specs_list_tables[0].css('.tr-toggle')[3].css('.nfo').text
    # four_g_bands = specs_list_tables[0].css('.tr-toggle')[4].css('.nfo').text
    # speed = specs_list_tables[0].css('.tr-toggle')[5].css('.nfo').text
    # gprs = specs_list_tables[0].css('.tr-toggle')[6].css('.nfo').text
    # edge = specs_list_tables[0].css('.tr-toggle')[7].css('.nfo').text




    {
      specs_brief: {
        'Released at' => review_header.css('.specs-brief-accent')[0].content,
        'Dimensions' => review_header.css('.specs-brief-accent')[1].content,
        'System' => review_header.css('.specs-brief-accent')[2].content,
        'memory' => review_header.css('.specs-brief-accent')[3].content,
        'display_size' => review_header.css('.help.accented.help-display .accent')[0].content,
        'resolution' => review_header.css('.help.accented.help-display')[0].children.last.content,
        'camera_photo' => review_header.css('.help.accented.help-camera').children[3].content,
        'camera_video' => review_header.css('.help.accented.help-camera').children[4].content,
        'ram' => review_header.css('.help.accented.help-expansion .accent-expansion').text,
        'chipset' => review_header.css('.help.accented.help-expansion').children[4].content,
        'batary_capacity' => review_header.css('.help.accented.help-battery .accent-battery').text,
        'batary_technology' => review_header.css('.help.accented.help-battery').children[4].content
      },
      specs_detaited: {
        'NETWORK' => {
          'Technology' => specs_list_tables[0].css('.tr-hover .nfo').text,
          '2G bands' => specs_list_tables[0].css('.tr-toggle')[0].css('.nfo').text,
          'blank 2G bands' => specs_list_tables[0].css('.tr-toggle')[1].css('.nfo').text,
          '3G bands' => specs_list_tables[0].css('.tr-toggle')[2].css('.nfo').text,
          'blank 3G bands' => specs_list_tables[0].css('.tr-toggle')[3].css('.nfo').text,
          '4G bands' => specs_list_tables[0].css('.tr-toggle')[4].css('.nfo').text,
          'Speed' => specs_list_tables[0].css('.tr-toggle')[5].css('.nfo').text,
          'GPRS' => specs_list_tables[0].css('.tr-toggle')[6].css('.nfo').text,
          'EDGE' => specs_list_tables[0].css('.tr-toggle')[7].css('.nfo').text
        },
        'LAUNCH' => {
          'Announced' => specs_list_tables[1].css('tr')[0].css('.nfo').text,
          'Status' => specs_list_tables[1].css('tr')[1].css('.nfo').text
        },
        'BODY' => {
          'Dimensions' => specs_list_tables[2].css('tr')[0].css('.nfo').text,
          'Weight' => specs_list_tables[2].css('tr')[1].css('.nfo').text,
          'SIM' => specs_list_tables[2].css('tr')[2].css('.nfo').text,
          'blank' => specs_list_tables[2].css('tr')[3].css('.nfo').text
        },
        'DISPLAY' => {
          'Type' => specs_list_tables[3].css('tr')[0].css('.nfo').text,
          'Size' => specs_list_tables[3].css('tr')[1].css('.nfo').text,
          'Resolution' => specs_list_tables[3].css('tr')[2].css('.nfo').text,
          'Multitouch' => specs_list_tables[3].css('tr')[3].css('.nfo').text,
          'Protection' => specs_list_tables[3].css('tr')[4].css('.nfo').text,
          'blank' => specs_list_tables[3].css('tr')[5].css('.nfo').text
        },
        'PLATFORM' => {
          'OS' => specs_list_tables[4].css('tr')[0].css('.nfo').text,
          'Chipset' => specs_list_tables[4].css('tr')[1].css('.nfo').text,
          'CPU' => specs_list_tables[4].css('tr')[2].css('.nfo').text,
          'GPU' => specs_list_tables[4].css('tr')[3].css('.nfo').text
        },
        'MEMORY' => {
          'Card slot' => specs_list_tables[5].css('tr')[0].css('.nfo').text,
          'Internal' => specs_list_tables[5].css('tr')[1].css('.nfo').text
        },
        'CAMERA' => {
          'Primary' => clean(specs_list_tables[6].css('tr')[0].css('.nfo').text),
          'Features' => specs_list_tables[6].css('tr')[1].css('.nfo').text,
          'Video' => clean(specs_list_tables[6].css('tr')[2].css('.nfo').text),
          'Secondary' => specs_list_tables[6].css('tr')[3].css('.nfo').text
        },
        'SOUND' => {
          'Alert types' => specs_list_tables[7].css('tr')[0].css('.nfo').text,
          'Loudspeaker' => specs_list_tables[7].css('tr')[1].css('.nfo').text,
          '3.5mm jack' => specs_list_tables[7].css('tr')[2].css('.nfo').text,
          'blank' => specs_list_tables[7].css('tr')[3].css('.nfo').text
        },
        'COMMS' => {

        },
        'FEATURES' => {

        },
        'BATTERY' => {

        },
        'MISC' => {

        },
        'TESTS' => {

        }
      }
    }

  end

  private

  def clean(string)
    string.gsub(', check quality', '')
  end
end
