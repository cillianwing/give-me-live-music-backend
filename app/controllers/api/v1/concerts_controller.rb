class Api::V1::ConcertsController < ApplicationController
  before_action :require_login
  
  def index
    concerts = session_user.concerts 
    if concerts
      render json: {concerts: concerts, success: "All concerts pulled successfully."}
    else
      render json: {failure: concerts.errors.full_messages}
    end
  end

  # def show
  #   concert = Concert.find(params[:id])
  # end

  def create 
    if session_user.concerts.create(concert_params)
      concert = session_user.concerts.last 
      render json: {concert: concert, success: "Concert successfully added to your calendar!"}
    else
      render json: {failure: concert.errors.full_messages}
    end
  end

  # def update 
  #   concert = Concert.find(params[:id])
  #   concert.update(concert_params)
  # end

  def destroy
    ticket = Ticket.find_by(concert_id: params[:id], user_id: session_user[:id])
    if ticket.destroy 
      render json: {success: "Successfully deleted concert from your calendar."}
    else
      render json: {failure: "Unable to delete concert from your calendar."}
    end
  end

  def upcoming 
    final_url = upcoming_search(params["search"])
    resp = Faraday.get(final_url)
    resp_json = JSON.parse(resp.body)["resultsPage"]
    render json: resp_json
  end

  def details
    final_url = concert_detail(params["concert"])
    resp = Faraday.get(final_url)
    resp_json = JSON.parse(resp.body)["resultsPage"]
    render json: resp_json
  end

  private

  def concert_params
    params.require(:concert).permit(:display, :event_type, :url, :venue_id, :venue_name, :city, :state, :date, :time,:api_id, :headline => [], :support => [])
  end

end