FactoryBot.define do
  factory :platform do
    name { 'platform_a' }
    fields { 
      { name: :name,
        address: :address,
        additional_address: nil,
        lat: :lat,
        lng: :lng,
        category: :category_id,
        closed: :closed, 
        hours: :hours,
        website: nil,
        phone: nil
      }
    }
    category_range { [1000, 1200] }
    hours_format { 'hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour' }
  end
end

