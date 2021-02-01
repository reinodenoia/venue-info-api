module Api
  module Venues
    class PlatformsController < ApplicationController
      before_action :load_venue

      def index
        data = PlatformsRecovery.new(@venue).recover
        raise_if_error(data.first) if data.all? { |d| d.key? :error }
        render_data(data)
      end

      def show
        platform = @venue.platforms.find(params[:id])
        data = platform.external_information(venue_id: @venue.id, method: :get)

        raise_if_error(data)
        render_data(data)

      rescue ActiveRecord::RecordNotFound => e
        raise NotFound, e.message
      end

      private 

      def load_venue
        @venue = Venue.find(params[:venue_id])
      rescue ActiveRecord::RecordNotFound => e
        raise NotFound, e.message
      end
    end
  end
end
