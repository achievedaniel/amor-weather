require 'open_weather/http_service'
require_relative '../config/constants'

# This SPEC tests the functionality of the HttpService class.
# It uses VCR to prevent over calling the API during development.
# Currently it only checks for an item in the response a future development idea is to test
# more elements of the response to ensure that the API still has the same structure.
# A good idea is to change the zip variable from time to time to refresh the VCR call
# to make sure that the API still responding the same way as it was recorded.
# Note that you will need to change the lat and lon variables once you change the zip.

RSpec.describe "HttpService (vcr)", vcr: { record: :new_episodes }  do
    let(:location_url)  {Configs.open_weather_zip_url}
    let(:weather_url) {Configs.open_weather_forecast_url}
    let(:zip) {'90210'}
    let(:country_code) {'US'}
    let(:lat) {34.0901}
    let(:lon) {-118.4065}
    let(:api_key) {Configs.open_weather_api_key}
    it 'returns lon and lat info based on zipcode' do
        subject = OpenWeather::HttpService.service("#{location_url}?zip=#{zip},#{country_code}&appid=#{api_key}")
        expect(subject.lat).to eq(34.0901)
    end

    it 'returns weather information based on lon and lan passed' do
        subject = OpenWeather::HttpService.service("#{weather_url}?lat=#{lat}&lon=#{lon}&units=imperial&appid=#{api_key}")
        expect(subject.lat).to eq(34.0901)
    end
end
