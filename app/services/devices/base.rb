module Devices
  class Base
    def id
      raise NotImplementedError
    end

    def model_name
      raise NotImplementedError
    end

    def brand_name
      raise NotImplementedError
    end

    def pic_url
      raise NotImplementedError
    end

    def full_name
      raise NotImplementedError
    end

    def parsed_data
      raise NotImplementedError
    end
  end
end
