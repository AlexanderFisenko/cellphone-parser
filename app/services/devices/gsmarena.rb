module Devices
  class Gsmarena < Base
    def initialize(id)
      @id = id
      @device = Search.new(id: @id).find_by_id
      @parsed_data = CellphoneDataScrapper.new(@id).scrap
    end

    def id
      @device[:model_id]
    end

    def model_name
      @device[:model_name]
    end

    def brand_name
      @device[:brand_name]
    end

    def pic_url
      @device[:pic_url]
    end

    def full_name
      @device[:full_name]
    end

    def parsed_data
      @parsed_data
    end
  end
end
