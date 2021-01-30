class PhoneFormatValidator < ActiveModel::EachValidator
  PHONE_REGEX = %r{^\+[0-9]{11}}

  def validate_each(record, attribute, value)
    return true unless value
    record.errors[attribute] << 'invalid' unless value.match?(%r{#{PHONE_REGEX}})
  end
end
