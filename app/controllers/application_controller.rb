class ApplicationController < ActionController::API
  before_action :require_login

  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      user_id = decoded_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    else
      nil 
    end
  end

  def logged_in?
    !!session_user
  end

  def require_login 
    render json: {message: "Please login."}, status: :unauthorized unless logged_in?
  end

  def encode_token(payload)
    JWT.encode(payload, 'my_secret')
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header 
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue => exception
        JWT::DecodeError
        []
      end
    end
  end

  def upcoming_search(input)
    location_url = "https://api.songkick.com/api/3.0/search/locations.json?query=#{input['city']}, #{input['city']}, US&apikey=#{ENV['SONGKICK_API_KEY']}"
    location_resp = Faraday.get(location_url)
    location_json = JSON.parse(location_resp.body)
    metro_area = location_json["resultsPage"]["results"]["location"][0]["metroArea"]["id"]

    base_url = "https://api.songkick.com/api/3.0/events.json?apikey=#{ENV['SONGKICK_API_KEY']}"
    location = "&location=sk:#{metro_area}"
    min_date = "&min_date=#{input["min_date"]}"
    max_date = "&max_date=#{input["max_date"]}"
    page = "&page=#{input["page"]}"

    final_url = "#{base_url}#{location}#{min_date}#{max_date}#{page}"
  end

  def concert_detail(input)
    detail_url = "https://api.songkick.com/api/3.0/events/#{input}.json?apikey=#{ENV['SONGKICK_API_KEY']}"
  end

end
