class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return unless record[attribute] && record[attribute] < Time.now.utc
    record.errors[attribute] << (options[:message] || "can't be in the past")
  end
end
