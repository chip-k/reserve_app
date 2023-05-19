module ApplicationHelper
  
  def number_with_hyphen_format(value)
    return value if value.blank?

    value.to_s.insert(3, '-')
  end
  
end
