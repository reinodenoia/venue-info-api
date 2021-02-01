module Platforms 
  class Api
    CONTENT_TYPE = 'application/json'.freeze

    def initialize; end

    def request(method, platform, api_key, body = {})
      url = build_url(platform, api_key)

      arguments = [url]
      arguments.push(body: { 'venue': body }) if body.any?

      response = HTTParty.send(method.to_s, *arguments)

      return { error: "Api::Errors::#{response.message.gsub!(/\s+/, '')}" } unless response.success?

      JSON.parse(response.body)
    end

    private

    def build_url(platform, api_key)
      "#{host}/#{platform}/venue?api_key=#{api_key}"
    end

    def host
      APP_CONFIG[:platforms][:api][:host]
    end
  end
end