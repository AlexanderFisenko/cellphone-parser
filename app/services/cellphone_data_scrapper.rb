class CellphoneDataScrapper
  def initialize(device_id)
    @device_id = device_id
    @url = generate_url
  end

  def scrap
    doc = Nokogiri::HTML(open(@url))
    review_header = doc.css('.review-header')

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

    {
      released_at: released_at,
      dimensions: dimensions,
      system: system,
      memory: memory,
      display_size: display_size,
      resolution: resolution,
      camera_photo: camera_photo,
      camera_video: camera_video,
      ram: ram,
      chipset: chipset,
      batary_capacity: batary_capacity,
      batary_technology: batary_technology
    }
  end

  private

  def generate_url
    "http://www.gsmarena.com/random-#{@device_id}.php"
  end
end
