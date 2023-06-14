class NameKanaValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, message: "が入力されていません。")
    else !value.match?(/\A[\p{Katakana}\p{Blank}ー－]+\z/)
      record.errors.add(attribute, message: "はカタカナで入力してください。")
    end
  end
  
end