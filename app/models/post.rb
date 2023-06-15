class Post < ApplicationRecord
  
  validates :title, presence: true
  validates :body, presence: true
  
  
  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end
  
end
