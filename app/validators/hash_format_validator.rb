class HashFormatValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << 'invalid' unless valid_hash_format(value)
  end

  private

  def valid_hash_format(value)
    return false unless value
    value.is_a?(Hash)
  rescue SyntaxError
    false
  end
end
