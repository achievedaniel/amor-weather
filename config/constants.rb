class Configs
   def self.open_weather_api_key
      ENV["OPEN_WEATER_KEY"]
   end

   def self.open_weather_forecast_url
      "https://api.openweathermap.org/data/3.0/onecall"
   end

   def self.open_weather_zip_url
      "http://api.openweathermap.org/geo/1.0/zip"
   end
end