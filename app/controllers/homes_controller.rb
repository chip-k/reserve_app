class HomesController < ApplicationController
  
  def index
    @posts = Post.order(created_at: :desc).limit(3)
    @admin = Admin.find(1)
  end
  
end
