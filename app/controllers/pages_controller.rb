class PagesController < ApplicationController

  def home
  end

  def search
    query = params[:query]

    @devices = Search.new(query: query).find_by_query
    if params[:typeahead]
      @devices = @devices.map { |device| { id: device[:model_id], name: device[:full_name], img: device[:pic_url] } }
      @devices = @devices.take(12)
    end

    respond_to do |format|
      format.js { render partial: 'search', locals: { devices: @devices } }
      format.json { render json: @devices }
    end
  end

  # def search_result
  #   @device_id = params[:device_id]
  # end

  def show_device
    device_id = params[:device_id]
    @device = Devices::Gsmarena.new(device_id)

    respond_to do |format|
      format.js { render partial: 'show_device', locals: { device: @device } }
    end
  end
end
