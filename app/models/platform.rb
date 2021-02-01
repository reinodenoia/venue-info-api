class Platform < ApplicationRecord
  has_many :assignments 
  has_many :venues, through: :assignments

  serialize :fields

  validates :name, :fields, :hours_format, presence: true
  validates :fields, { hash_format: true }
  validates :category_range, length: { is: 2 }
  validates_length_of :hours_format, in: 69..97
  validates_uniqueness_of :name

  def external_information(venue_id:, method:, body: {})
    api_key = self.assignments.find_by(venue_id: venue_id).api_key
    Platforms::Api.new.request(method, self.name, api_key, transform_body(body))
  end

  def transform_body(body)
    updated_body = body.dup
    return {} unless updated_body.any?
    updated_body[:category] = transform_category(updated_body[:category])
    updated_body.transform_keys! do |key|
      self.fields[key.to_sym]
    end
    updated_body.delete_if { |key, value| key.nil? || key.eql?('nil') }
    updated_body[:hours] = transform_hours(updated_body[:hours])
    updated_body
  end

  def transform_hours(hours)
    hours_list = hours.map { |hour| hour.split('-') }.flatten
    hours_list.each { |hour| hours_format.sub!('hour', hour) }
    hours_format
  end

  def transform_category(category)
    category_range.first + category
  end
end
