class Article < ApplicationRecord
  
  belongs_to :temple
  
  has_one_attached :image
  
  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end
  
end
