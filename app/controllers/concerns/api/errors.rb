module Api
  module Errors
    extend ActiveSupport::Concern

    ERRORS = {
      bad_request: {
        http_code: 400
      },
      not_found: {
        http_code: 404
      },
      invalid_parameter: {
        http_code: 422
      },
      routing_error: {
        http_code: 500
      }
    }.freeze

    ERRORS.each { |error, _| const_set error.to_s.camelize, Class.new(StandardError) }

    included do
      ERRORS.each do |error, val|
        error = error.to_s.camelize

        rescue_from "Api::Errors::#{error}".constantize do |exception|
          render(
            json: {
              error: { message: "#{error}: #{exception}" }
            },
            status: val[:http_code]
          )
        end
      end
    end
  end
end