class VenueUpdater
  def initialize(venue, params)
    @venue = venue
    @params = params
    @responses = []
  end

  def update
    @venue.platforms.each do |platform|
      thread = Thread.new do
        data = platform.external_information(venue_id: @venue.id, method: :patch, body: @params)
        @responses.push({ platform: platform.name, internal_id: platform.id }.merge!(data))
      end
      thread.join
    end

    if @responses.any? { |response| response[:error].present? }
      current_params = @venue.attributes.except!(*%w[id created_at updated_at])
      @responses.select { |response| response[:error].blank? }.map { |pf| pf[:internal_id] }.each do |id|
        @venue.platforms.find_by(id: id).external_information(venue_id: @venue.id, method: :patch, body:  current_params)
      end
      raise raise Api::Errors::BadRequest
    end

    @venue.update(@params)
  end
end