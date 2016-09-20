class DevicesController < ApplicationController

  def index
    if request.xhr?
      query = params[:query]

      @devices = Search.new(query: query).find_by_query
      if params[:typeahead]
        @devices = @devices.map { |device| { id: device[:model_id], name: device[:full_name], img: device[:pic_url] } }
        @devices = @devices.take(12)
      end
    end

    respond_to do |format|
      format.js
      format.json { render json: @devices }
      format.html
    end
  end

  def show
    device_id = params[:id]
    @device = Devices::Gsmarena.new(device_id)

    respond_to do |format|
      format.js
    end
  end

end
