FactoryBot.define do
  factory :venue do
    name { 'Waelchi-Lindgren' }
    address { '9821 Boehm Falls' }
    lat { 15.8928681484 }
    long { 101.3330876089 } 
    category { 0 }
    closed { true }
    hours { %w[10:00-22:00 10:00-22:00 10:00-22:00 10:00-22:00 10:00-22:00 11:00-18:00 11:00-18:00] }
    website { 'https://localistico.com' }
    phone { '+34666999666' }
  end
end
