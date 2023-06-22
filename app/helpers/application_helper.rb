module ApplicationHelper
  
  # 郵便番号、電話番号にハイフンを付ける
  def number_with_hyphen_format(value)
    return value if value.blank?

    case value.to_s.length
    when 7
      value.to_s.insert(3, '-')
    when 10
      value.to_s.insert(3, '-').insert(7, '-')
    when 11
      value.to_s.insert(3, '-').insert(8, '-')
    else
      value
    end
    
  end
  
  
  #フラッシュメッセージのスタイルを設定
  def bootstrap_alert(key)
    case key
      when "alert"
       "warning"
      when "notice"
        "success"
      when "error"
       "danger"
      when "secondary"
       "secondary"
      when "success"
       "success"
      when "danger"
       "danger"
      when "warning"
       "warning"
      when "info"
       "info"
      when "light"
       "light"
      when "dark"
       "dark"
    end
  end
  
end
