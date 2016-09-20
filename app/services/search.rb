require 'open-uri'

class Search
  ORIGINAL_URL = 'http://www.gsmarena.com/'

  def initialize(query: nil, id: nil)
    @query = query
    @id = id
  end

  def find_by_query
    fake_db.select { |device| device[:searchable_text].match(/#{@query}/i).present? }.compact
  end

  def find_by_id
    fake_db.find { |device| device[:model_id] == @id.to_i }
  end

  private

  def fake_db
    @fake_db ||= gsmarena_devices.map do |device|
      brand_id = device[0].to_s
      model_id = device[1]
      model_name = device[2]
      brand_name = gsmarena_brands[brand_id]
      tags = device[3]
      pic_path = device[4]
      searchable_text = [brand_name, model_name, tags].join(' ')
      full_name = "#{brand_name} #{model_name}"
      pic_url = generate_image_url(pic_path)

      {
        brand_id: brand_id,
        model_id: model_id,
        model_name: model_name,
        brand_name: brand_name,
        tags: tags,
        pic_path: pic_path,
        searchable_text: searchable_text,
        full_name: full_name,
        pic_url: pic_url
      }
    end
  end

  def gsmarena_brands
    @gsmarena_brands ||= gsmarena_data[0]
  end

  def gsmarena_devices
    gsmarena_data[1]
  end

  def gsmarena_data
    # in case gsmarena_data_path will be changed
    Rails.cache.fetch('gsmarena_cellphones_data', expires_in: 1.day) do
      data = open(ORIGINAL_URL).read
      gsmarena_data_path = data.match(/AUTOCOMPLETE_LIST_URL = "\/(.*)"/)[1]
      gsmarena_data_path = ORIGINAL_URL + gsmarena_data_path
      uri = URI.parse(gsmarena_data_path)
      JSON.parse(uri.read)
    end
  end

  def generate_image_url(path)
    'http://cdn2.gsmarena.com/vv/bigpic/' + path
  end
end
