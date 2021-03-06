platforms_params = [
  {
    name: 'platform_a',
    fields: { name: :name,
              address: :address,
              additional_address: nil,
              lat: :lat,
              lng: :lng,
              category: :category_id,
              closed: :closed, 
              hours: :hours,
              website: nil,
              phone: nil
            },
    category_range: [1000, 1200],
    hours_format: 'hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour'
  },
  {
    name: 'platform_b',
    fields: { name: :name,
              address: :street_address,
              additional_address: nil,
              lat: :lat,
              lng: :lng,
              category: :category_id,
              closed: :closed, 
              hours: :hours,
              website: nil,
              phone: nil
            },
    category_range: [2000, 2200],
    hours_format: 'Mon:hour-hour|Tue:hour-hour|Wed:hour-hour|Thu:hour-hour|Fri:hour-hour|Sat:hour-hour|Sun:hour-hour'
  },
  {
    name: 'platform_c',
    fields: { name: :name,
      address: :address_line_1,
      additional_address: :address_line_2,
      lat: :lat,
      lng: :lng,
      category: :nil,
      closed: :closed, 
      hours: :hours,
      website: :website,
      phone: :phone_number
    },
    hours_format: 'hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour'
  }
]

def run(log)
  puts "* #{log}..."
  yield
end

def log(msg)
  puts "    #{msg}"
end

run('Cleaning database') do
  %w[assignment platform venue].each do |model|
    log "Cleaning #{model.pluralize} table..."
    model.capitalize.constantize.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!(model.pluralize)
  end
end

run('Create venue') do
  @venue = FactoryBot.create(:venue)
  log "#{@venue.name} venue"
end


run('Create platforms') do
  @platforms = []
  platforms_params.each do |platform_params|
    platform = FactoryBot.create(:platform, platform_params)
    log "#{platform.name} platform"
    @platforms << platform
  end
end

run('Create assignments') do
  @platforms.each do |platform|
    FactoryBot.create(:assignment, platform_id: platform.id, venue_id: @venue.id, api_key: APP_CONFIG[:platforms][:api][:api_key])
    log "assignment between #{platform.name} platform and #{@venue.name} venue created"
  end
end
