class Post < ApplicationRecord
  
  belongs_to :admin
  
  
  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end
  
end
