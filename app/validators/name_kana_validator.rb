class NameKanaValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, message: "が入力されていません。")
    elsif !value.match?(/\A[\p{katakana}\u{30fc}]+\z/)
      record.errors.add(attribute, message: "はカタカナで入力してください。")
    end
  end
  
end