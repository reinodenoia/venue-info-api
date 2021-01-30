FactoryBot.define do
  factory :assignment do
    association :venue
    association :platform
    api_key { 'wololo' }
  end
end
