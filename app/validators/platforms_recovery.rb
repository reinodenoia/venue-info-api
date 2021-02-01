class PlatformsRecovery

  def initialize(venue)
    @venue = venue
    @responses = []
  end

  def recover
    @venue.platforms.each do |platform|
      thread = Thread.new do
        data = platform.external_information(venue_id: @venue.id, method: :get)
        @responses.push({ platform: platform.name, internal_id: platform.id }.merge!(data))
      end
      thread.join
    end

    @responses
  end
end
