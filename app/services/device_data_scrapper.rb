class DeviceDataScrapper
  def initialize(device_id)
    @device_id = device_id
  end

  def scrape
    doc = Nokogiri::HTML(open("http://www.gsmarena.com/random-#{@device_id}.php"))
    review_header = doc.css('.review-header')
    specs_list_tables = doc.css('#specs-list table')

    specs_brief = {
      released_at: review_header.css('.specs-brief-accent')[0].content,
      dimensions: review_header.css('.specs-brief-accent')[1].content,
      system: review_header.css('.specs-brief-accent')[2].content,
      memory: review_header.css('.specs-brief-accent')[3].content,
      display_size: review_header.css('.help.accented.help-display .accent')[0].content,
      resolution: review_header.css('.help.accented.help-display')[0].children.last.content,
      camera_photo: review_header.css('.help.accented.help-camera').children[3].content,
      camera_video: review_header.css('.help.accented.help-camera').children[4].content,
      ram: review_header.css('.help.accented.help-expansion .accent-expansion').text,
      chipset: review_header.css('.help.accented.help-expansion').children[4].content,
      batary_capacity: review_header.css('.help.accented.help-battery .accent-battery').text,
      batary_technology: review_header.css('.help.accented.help-battery').children[4].content
    }

    specs_detailed = {}
    specs_list_tables.each do |table_node|
      section_title = table_node.css('tr')[0].css('th').text
      specs_detailed[section_title] = {}

      table_node.css('tr').each do |tr_node|
        td_nodes = tr_node.css('td')
        next if td_nodes.blank?
        subtitle = td_nodes[0].text
        info = td_nodes[1].text

        specs_detailed[section_title][subtitle] = info
      end
    end

    { specs_brief: specs_brief, specs_detailed: specs_detailed }
  end
end
