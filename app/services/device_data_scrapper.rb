class DeviceDataScrapper
  def initialize(device_id)
    @device_id = device_id
  end

  def scrap
    doc = Nokogiri::HTML(open("http://www.gsmarena.com/random-#{@device_id}.php"))
    review_header = doc.css('.review-header')
    specs_list_tables = doc.css('#specs-list table')

    specs_detaited = {}
    specs_list_tables.each do |table_node|
      section_title = table_node.css('tr')[0].css('th').text
      specs_detaited[section_title] = {}

      table_node.css('tr').each do |tr_node|

        td_nodes = tr_node.css('td')
        next if td_nodes.blank?
        subtitle = td_nodes[0].text
        info = td_nodes[1].text

        specs_detaited[section_title][subtitle] = info
      end
    end
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
      specs_detaited: specs_detaited
    }
    #     'NETWORK' => {
    #       'Technology' => specs_list_tables[0].css('.tr-hover .nfo').text,
    #       '2G bands' => specs_list_tables[0].css('.tr-toggle')[0].css('.nfo').text,
    #       'blank 2G bands' => specs_list_tables[0].css('.tr-toggle')[1].css('.nfo').text,
    #       '3G bands' => specs_list_tables[0].css('.tr-toggle')[2].css('.nfo').text,
    #       'blank 3G bands' => specs_list_tables[0].css('.tr-toggle')[3].css('.nfo').text,
    #       '4G bands' => specs_list_tables[0].css('.tr-toggle')[4].css('.nfo').text,
    #       'Speed' => specs_list_tables[0].css('.tr-toggle')[5].css('.nfo').text,
    #       'GPRS' => specs_list_tables[0].css('.tr-toggle')[6].css('.nfo').text,
    #       'EDGE' => specs_list_tables[0].css('.tr-toggle')[7].css('.nfo').text
    #     },
    #     'LAUNCH' => {
    #       'Announced' => specs_list_tables[1].css('tr')[0].css('.nfo').text,
    #       'Status' => specs_list_tables[1].css('tr')[1].css('.nfo').text
    #     },
    #     'BODY' => {
    #       'Dimensions' => specs_list_tables[2].css('tr')[0].css('.nfo').text,
    #       'Weight' => specs_list_tables[2].css('tr')[1].css('.nfo').text,
    #       'SIM' => specs_list_tables[2].css('tr')[2].css('.nfo').text,
    #       'blank' => specs_list_tables[2].css('tr')[3].css('.nfo').text
    #     },
    #     'DISPLAY' => {
    #       'Type' => specs_list_tables[3].css('tr')[0].css('.nfo').text,
    #       'Size' => specs_list_tables[3].css('tr')[1].css('.nfo').text,
    #       'Resolution' => specs_list_tables[3].css('tr')[2].css('.nfo').text,
    #       'Multitouch' => specs_list_tables[3].css('tr')[3].css('.nfo').text,
    #       'Protection' => specs_list_tables[3].css('tr')[4].css('.nfo').text,
    #       'blank' => specs_list_tables[3].css('tr')[5].css('.nfo').text
    #     },
    #     'PLATFORM' => {
    #       'OS' => specs_list_tables[4].css('tr')[0].css('.nfo').text,
    #       'Chipset' => specs_list_tables[4].css('tr')[1].css('.nfo').text,
    #       'CPU' => specs_list_tables[4].css('tr')[2].css('.nfo').text,
    #       'GPU' => specs_list_tables[4].css('tr')[3].css('.nfo').text
    #     },
    #     'MEMORY' => {
    #       'Card slot' => specs_list_tables[5].css('tr')[0].css('.nfo').text,
    #       'Internal' => specs_list_tables[5].css('tr')[1].css('.nfo').text
    #     },
    #     'CAMERA' => {
    #       'Primary' => clean(specs_list_tables[6].css('tr')[0].css('.nfo').text),
    #       'Features' => specs_list_tables[6].css('tr')[1].css('.nfo').text,
    #       'Video' => clean(specs_list_tables[6].css('tr')[2].css('.nfo').text),
    #       'Secondary' => specs_list_tables[6].css('tr')[3].css('.nfo').text
    #     },
    #     'SOUND' => {
    #       'Alert types' => specs_list_tables[7].css('tr')[0].css('.nfo').text,
    #       'Loudspeaker' => specs_list_tables[7].css('tr')[1].css('.nfo').text,
    #       '3.5mm jack' => specs_list_tables[7].css('tr')[2].css('.nfo').text,
    #       'blank' => specs_list_tables[7].css('tr')[3].css('.nfo').text
    #     },
    #     'COMMS' => {
    #       'WLAN' => specs_list_tables[8].css('tr')[0].css('.nfo').text,
    #       'Bluetooth' => specs_list_tables[8].css('tr')[1].css('.nfo').text,
    #       'GPS' => specs_list_tables[8].css('tr')[2].css('.nfo').text,
    #       'NFC' => specs_list_tables[8].css('tr')[3].css('.nfo').text,
    #       'Radio' => specs_list_tables[8].css('tr')[4].css('.nfo').text,
    #       'USB' => specs_list_tables[8].css('tr')[5].css('.nfo').text
    #     },
    #     'FEATURES' => {
    #       'Sensors' => specs_list_tables[9].css('tr')[0].css('.nfo').text,
    #       'Messaging' => specs_list_tables[9].css('tr')[1].css('.nfo').text,
    #       'Browser' => specs_list_tables[9].css('tr')[2].css('.nfo').text,
    #       'Java' => specs_list_tables[9].css('tr')[3].css('.nfo').text,
    #       'blank' => specs_list_tables[9].css('tr')[4].css('.nfo').text
    #     },
    #     'BATTERY' => {
    #       'blank' => specs_list_tables[10].css('tr')[0].css('.nfo').text,
    #       'Talk time' => specs_list_tables[10].css('tr')[1].css('.nfo').text,
    #       'Music play' => specs_list_tables[10].css('tr')[2].css('.nfo').text
    #     },
    #     'MISC' => {
    #       'Colors' => specs_list_tables[11].css('tr')[0].css('.nfo').text,
    #       'Price group' => specs_list_tables[11].css('tr')[1].css('.nfo').text
    #     },
    #     'TESTS' => {
    #       'Camera' => specs_list_tables[12].css('tr')[0].css('.nfo').text
    #     }
    #   }
    # }

  end

  private

  def clean(string)
    string.gsub(', check quality', '')
  end
end
