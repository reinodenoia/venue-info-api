class Platform < ApplicationRecord
  has_many :assignments 
  has_many :venues, through: :assignments

  serialize :fields

  validates :name, :fields, :hours_format, presence: true
  validates :fields, { hash_format: true }
  validates :category_range, length: { is: 2 }
  validates_length_of :hours_format, in: 69..97
  validates_uniqueness_of :name
end
