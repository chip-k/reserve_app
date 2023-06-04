class ArticlesController < ApplicationController
  before_action :authenticate_temple!, only: [:create, :edit, :update, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    article = Article.new(article_params)
    article.temple_id = current_temple.id
    if article.save
      flash[:success] = "投稿に成功しました。"
      redirect_to article_path(temple_id: article.temple_id, id: article.id)
    else
      flash[:danger] = "投稿に失敗。"
      render :new
    end
  end

  def index
    temple_id = params[:temple_id]
    @temple = Temple.find(temple_id)
    @articles = @temple.articles.order(created_at: :desc)
  end

  def show
    temple_id = params[:temple_id]
    @temple = Temple.find(temple_id)
    @article = Article.find(params[:id])
  end
  
  def edit
    temple_id = params[:temple_id]
    @temple = Temple.find(temple_id)
    @article = Article.find(params[:id])
  end
  
  def update
    article = Article.find(params[:id])
    article.temple_id = current_temple.id
    if article.update(article_params)
      flash[:success] = "投稿を編集しました。"
      redirect_to article_path(temple_id: article.temple_id, id: article.id)
    else
      flash[:danger] = "投稿を編集できませんでした。"
      render :edit
    end
  end
  
  def destroy
    @temple = current_temple.id
    article = Article.find(params[:id])
    if article.destroy
      flash[:success] = "投稿を削除しました。"
      redirect_to articles_path(temple_id: @temple)
    else
      flash[:danger] = "投稿を削除できませんでした。"
      render :show
    end
  end
  
  
  private
  
  def article_params
    params.require(:article).permit(:title, :content, :temple_id)
  end
  
end