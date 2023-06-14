class Article < ApplicationRecord
  
  validates :title, presence: true
  validates :content, presence: true
  
  belongs_to :temple
  
  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end
  
end
