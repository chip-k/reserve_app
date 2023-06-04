class PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
    flash[:success] = "投稿に成功しました。"
    redirect_to post_path(post.id)
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    flash[:success] = "投稿を編集しました。"
    redirect_to post_path(post.id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:danger] = "投稿を削除しました。"
    redirect_to posts_path
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end
