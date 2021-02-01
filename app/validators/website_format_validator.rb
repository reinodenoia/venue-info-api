class WebsiteFormatValidator < ActiveModel::EachValidator
  WEBSITE_REGEX = %r{^(http|https):\/\/[a-z0-9]+([\-_~\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$}

  def validate_each(record, attribute, value)
    return true unless value
    record.errors[attribute] << 'invalid' unless value.match?(%r{#{WEBSITE_REGEX}})
  end
end
