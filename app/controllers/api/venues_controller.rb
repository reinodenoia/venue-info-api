module Api
  class VenuesController < ApplicationController
    before_action :load_venue, only: :update

    def show
      @venue = Venue.find(params[:id])
      render_data @venue

    rescue ActiveRecord::RecordNotFound => e
      raise NotFound, e.message
    end

    def update
      @venue.full_update(update_params.to_h)
    end

    private

    def update_params
      params.require(:venue)
            .permit(:name, :address, :additional_address, :lat, :lng,
              :category, :closed, :website, :phone, hours: [])
    end

    def load_venue
      @venue = Venue.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise NotFound, e.message
    end
  end
end