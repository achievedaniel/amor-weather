module OpenWeather
  class DailyForecast
      def initialize
        @forecast_url = Configs.open_weather_forecast_url
        @location_url = Configs.open_weather_zip_url
        @api_key = Configs.open_weather_api_key
      end

      def all_weather(lat, lon)
        Rails.cache.fetch("#{lat}#{lon}", expires_in: 30.minutes) do
          HttpService.service("#{@forecast_url}?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{@api_key}")
        end
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
  end
end