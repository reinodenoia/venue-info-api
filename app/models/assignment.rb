class Assignment < ApplicationRecord
  belongs_to :venue
  belongs_to :platform

  validates :api_key, presence: true
  validates_uniqueness_of :venue_id, scope: :platform_id
end
