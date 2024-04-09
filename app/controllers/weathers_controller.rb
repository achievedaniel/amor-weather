require "#{Rails.root}/lib/open_weather/daily_forecast"

class WeathersController < ApplicationController
  def main
  end

  # Using the call to the .zip_location to handle any zip code imputs.
  # Future development to not relly on the API response and create a more 
  # robust input checker for different zip codes from different countries.

  def forecast
    params.permit(:zip, :country)
    @zip_data = get_lat_lon(params[:zip], params[:country])
    if @zip_data.zip
      @cash_used = @open_weather.data_from_cash?(@zip_data.lat,@zip_data.lon)
      @current_weather = @open_weather.current_weather(@zip_data.lat,@zip_data.lon)
      @daily_forecast = @open_weather.daily_forecast(@zip_data.lat,@zip_data.lon)
    else
      render :error
    end
  end

  # You can use this controller to see how the API response is structured by using the /all route.

  def pre_json
    open_weather = OpenWeather::DailyForecast.new
    @zip_data = open_weather.zip_location('17050', 'US')
    @all_weather = open_weather.current_weather(@zip_data.lat,@zip_data.lon)
    render json: @all_weather
  end

  private

  def get_lat_lon(zip_code, country)
    @open_weather = OpenWeather::DailyForecast.new
    @open_weather.zip_location(zip_code, country)
  end

end



