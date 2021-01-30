FactoryBot.define do
  factory :platform do
    name { 'platform_a' }
    fields { 
      { name: :name,
        address: :address,
        aditional_adress: nil,
        lat: :lat,
        long: :long,
        category: :category_id,
        closed: :closed, 
        hours: :hours,
        website: nil,
        phone: nil
      }.to_s
    }
    category_range { [1000, 1200] }
    hours_format { 'hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour|hour-hour' }
  end
end

