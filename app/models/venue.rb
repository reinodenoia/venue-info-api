class Venue < ApplicationRecord
  include ActiveModel::AttributeAssignment

  has_many :assignments
  has_many :platforms, through: :assignments

  validates :name, :address, :lat, :lng, :closed, :category, presence: true
  validates_inclusion_of :category, in: 0..200
  validates :hours, length: { is: 7 }
  validates :hours, { hours_format: true }
  validates :website, { website_format: true }
  validates :phone, { phone_format: true }
  validates_uniqueness_of :name

  def full_update(params)
    self.assign_attributes(params)
    unless self.valid?
      raise Api::Errors::InvalidParameter, self.errors.messages
    end

    VenueUpdater.new(self, params).update
  end
end
