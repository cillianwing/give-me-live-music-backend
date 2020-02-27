class Api::V1::ConcertsController < ApplicationController
  before_action :require_login
  
  # def index
  #   concerts = session_user.concerts 
  #   render json: concerts.to_json()
  # end

  # def show
  #   concert = Concert.find(params[:id])
  # end

  def create 
    concert = session_user.concerts.new(concert_params)
    if concert.valid?
      concert.save
      render json: {concert: concert, success: "Concert successfully added to your calendar!"}
    else
      render json: {failure: concert.errors.full_messages}
    end
  end

  # def update 
  #   concert = Concert.find(params[:id])
  #   concert.update(concert_params)
  # end

  # def destroy 
  #   concert = Concert.find(params[:id])
  #   concert.destroy 
  # end

  def upcoming 
    final_url = upcoming_search(params["search"])
    resp = Faraday.get(final_url)
    resp_json = JSON.parse(resp.body)["resultsPage"]
    render json: resp_json
  end

  private

  def concert_params
    params.require(:concert).permit(:display, :type, :url, :venue_id, :venue_name, :city, :state, :date, :time,:api_id, :headline => [], :support => [])
  end

end