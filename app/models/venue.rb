class Venue < ApplicationRecord
  has_many :assignments
  has_many :platforms, through: :assignments

  validates :name, :address, :lat, :long, :closed, :category, presence: true
  validates_inclusion_of :category, in: 0..200
  validates :hours, length: { is: 7 }
  validates :hours, { hours_format: true }
  validates :website, { website_format: true }
  validates :phone, { phone_format: true }
  validates_uniqueness_of :name
end
