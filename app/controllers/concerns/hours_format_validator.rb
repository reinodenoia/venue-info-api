class HoursFormatValidator < ActiveModel::EachValidator
  HOUR_RANGE_REGEX = %r{^(?:(?:(?:0[0-9]|1[0-9]|2[0-3]):[0-5][0-9])-(?:(?:0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]))}

  def validate_each(record, attribute, value)
    record.errors[attribute] << 'invalid' unless valid_array_values(value)
  end

  private 

  def valid_array_values(value)
    value.map { |value| value.match?(%r{#{HOUR_RANGE_REGEX}}) }.all?
  end
end
