# README

Amor Weather is a weather website that uses the OpenWeather API https://openweathermap.org/api.
it currently supports US and Canada and it is only in English with more countries and languages possible.

We are using ruby 3.3 and rails 7.1.3. 
    Gems needed to run locally (besides the standard gems):
    Rspec
    rspec-rails
    VCR
    webmock
    Dotenv
    jsbundling-rails

Amor weather also uses bootstrap added to the Procfile.dev and to the required .js files.


Backend

The backend is all handled by the OpenWeather module with two classes one to handle the HTTP request. The HTTP class is a simple class with a class method to prevent having unnecessary objects initiated. 
The DailyForecast handles processing the data. The all_weather method (private) is the gateway to the API calling and/or cashing the API data. This is so we don't make unnecessary calls to the API for different parts of the weather data.
The methods current_weather and daily_forecast simply filtered the data by using the OpenStructure and returning the called sections needed. As we are caching the data this will not cause multiple calls to the API and will simple filtered the cached data to simplify the structure for the frontend.
The method zip_location simply returns the lat and lon for the weather call. The if block is to return the call regardless if the user picked the right country. Future development here is to create a better validation for different zip code formats from different countries so we can integrate other countries.

Frontend

The frontend is a two page abroach where the landing page is waiting for the user to type the zip code. Once the user sends the zip code it calls the forecast controller inside of weathers_controllers. This method handles initiating the instance variables needed for the current_weather and the daily forecast. 
This data is then populated in different partials to make it easier for future development where this partials can be used in different sections of the website.
We also have a partial that is rendered if the zip code is not valid.
The layout is built with bootstrap with custom pictures. 

Testing

The backend has two specs for each of the OpenWeather module classes. We are utilizing the VCR gem to prevent calling the API unnecessarily. We are testing one data point from each off the methods. A future development would be to add tests for every data point to check for changes in the API.

Hosting

We are using Heroku as our hosting with a custom domain www.amorweather.com. The domain is managed through Squarespace. The current development is manual and there is only one stage for demonstration purposes. For real production we would need a more robust infrastructure with multiple stages and auto deployment. The stages also stores the API key in a config var. Locally we are using the gem dotenv and you will need to contact the owner to obtain an API key to run locally. 