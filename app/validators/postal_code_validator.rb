class PostalCodeValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, message: "が入力されていません。")
    elsif !value.to_s.match?(/\A\d{7}\z/)
      record.errors.add(attribute, message: "は7桁の数字のみ入力してください。")
    end
  end
  
end