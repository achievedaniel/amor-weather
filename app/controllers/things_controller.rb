require "#{Rails.root}/lib/open_weather/daily_forecast"

class ThingsController < ApplicationController
  def index
    params.permit(:zip)
    zip_code = params[:zip]
    open_weather = OpenWeather::DailyForecast.new
    @zip_data = open_weather.zip_location(zip_code, "US")
    @current_weather = open_weather.current_weather(@zip_data.lat,@zip_data.lon)
  end

  def new
    p = params
    t= 1
  end
  
end
