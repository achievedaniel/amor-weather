require "#{Rails.root}/lib/open_weather/daily_forecast"

class WeathersController < ApplicationController
  def main
  end

  def forecast
    params.permit(:zip, :country)
    @zip_data = get_lat_lon(params[:zip], params[:country])
    if @zip_data.zip
      @current_weather = @open_weather.current_weather(@zip_data.lat,@zip_data.lon)
      @daily_forecast = @open_weather.daily_forecast(@zip_data.lat,@zip_data.lon)
    else
      render :error
    end
  end

  def pre_json
    open_weather = OpenWeather::DailyForecast.new
    @zip_data = open_weather.zip_location('17050', 'US')
    @all_weather = open_weather.daily_forecast(@zip_data.lat,@zip_data.lon)
    render json: @all_weather
  end

  private

  def get_lat_lon(zip_code, country)
    @open_weather = OpenWeather::DailyForecast.new
    @open_weather.zip_location(zip_code, country)
  end

end



