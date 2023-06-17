class PhoneNumberValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, message: "が入力されていません。")
    elsif !value.match?(/\A0\d{9,10}\z/)
      record.errors.add(attribute, message: "は0から始まる10-11桁の数字のみ入力してください。")
    end
  end
  
end