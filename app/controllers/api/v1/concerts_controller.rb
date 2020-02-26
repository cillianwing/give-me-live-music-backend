class Api::V1::ConcertsController < ApplicationController
  before_action :require_login
  
  # def index
  #   concerts = session_user.concerts 
  #   render json: concerts.to_json()
  # end

  # def show
  #   concert = Concert.find(params[:id])
  # end

  # def create 
  #   concert = Concert.new(concert_params)
  #   concert.user = session_user
  # end

  # def update 
  #   concert = Concert.find(params[:id])
  #   concert.update(concert_params)
  # end

  # def destroy 
  #   concert = Concert.find(params[:id])
  #   concert.destroy 
  # end

  # def upcoming 
  #   base_url = "http://api.eventful.com/json/events/search?app_key=#{ENV['EVENTFUL_API_KEY']}"
  #   location_string = !params["search"]["location"].empty? ? "&location=#{params["search"]["location"]}" : ''
  #   date_string = !params["search"]["date"].empty? ? "&date=#{params["search"]["date"]}" : ''
  #   within_string = !params["search"]["within"].empty? ? "&within=#{params["search"]["within"]}&units=mi" : ''
  #   page_string = !params["search"]["page_number"].empty? ? "&page_number=#{params["search"]["page_number"]}" : ''
  #   final_url = "#{base_url}#{location_string}#{date_string}&category=music#{within_string}&page_size=30#{page_string}"
    
  #   resp = Faraday.get(final_url)
  #   resp_json = JSON.parse(resp.body)
  #   render json: resp_json
  # end

  private

  def concert_params
    params.require(:concert).permit(:display, :type, :url, :venue_id, :venue_name, :location, :location_lat, :location_long, :date, :time, :headline, :support, :api_id)
  end


end