require 'net/https'
require 'json'

# Separate HTTP service so it can be used for multiple potential APIs in the future.
module OpenWeather
    class HttpService
        def self.service(uri)
            url = URI.parse(uri)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host) do |http|
                http.request(req)
            end
            JSON.parse(res.body, object_class: OpenStruct)
        end
    end
end