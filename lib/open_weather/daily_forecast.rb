# Class to handle the data from the OpenWeather API.
# It makes two calls one to the location endpoint to find the zip lat and lon
# and another to the weather endpoint for all the weather data for the zip
# the API allows the data to be filtered but then we would have more calls to the API that
# needed by calling the API once and saving the data as an OpenStructure it allows us to
# call different parts of the response as needed without calling the API multiple times.
# We are currently cashing the data for 30 minutes. This is sufficient for demonstration
# purposes. However for real use we wuould want to lower the cash which will increase the API costs.
module OpenWeather
  class DailyForecast
      def initialize
        @forecast_url = Configs.open_weather_forecast_url
        @location_url = Configs.open_weather_zip_url
        @api_key = Configs.open_weather_api_key
      end

      def zip_location(zip, country_code)
        zip_data = HttpService.service("#{@location_url}?zip=#{zip},#{country_code}&appid=#{@api_key}")
        if zip_data.zip
          return zip_data
        elsif country_code == 'US'
          return HttpService.service("#{@location_url}?zip=#{zip},#{'CA'}&appid=#{@api_key}")
        elsif country_code == 'CA'
          return HttpService.service("#{@location_url}?zip=#{zip},#{'US'}&appid=#{@api_key}")
        end
      end

      def current_weather(lat, lon)
        all_weather(lat, lon).current
      end

      def daily_forecast(lat, lon)
        all_weather(lat, lon).daily
      end

      def data_from_cash?(lat, lon)
        if Rails.cache.read("#{lat}#{lon}")
          return true
        else
          return false
        end
      end

      private

      def all_weather(lat, lon)
        Rails.cache.fetch("#{lat}#{lon}", expires_in: 30.minutes) do
          HttpService.service("#{@forecast_url}?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{@api_key}")
        end
      end
  end
end