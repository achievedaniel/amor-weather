require 'net/https'
require 'json'
module OpenWeather
    class HttpService
        def self.service(uri)
            puts uri
            url = URI.parse(uri)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host) do |http|
                http.request(req)
            end
            # TODO create a data processor, create a service to translate zip code, create a servise to translate locations
            JSON.parse(res.body, object_class: OpenStruct)
        end
    end
end