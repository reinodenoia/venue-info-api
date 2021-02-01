module Platforms 
  class Api
    CONTENT_TYPE = 'application/json'.freeze

    def initialize; end

    def request(method, platform, api_key, body = {})
      url = build_url(platform, api_key)

      request_params = build_request_params(body)

      response = HTTParty.send(method.to_s, *[url, request_params])

      return { error: "Api::Errors::#{response.message.gsub!(/\s+/, '')}" } unless response.success?

      JSON.parse(response.body)
    end

    private

    def build_url(platform, api_key)
      "#{host}/#{platform}/venue?api_key=#{api_key}"
    end

    def build_request_params(body = {})
      params = { headers: { 'Content-type' => CONTENT_TYPE }}
      params.merge!(body: body) if body.any?
      params
    end

    def host
      APP_CONFIG[:platforms][:api][:host]
    end
  end
end