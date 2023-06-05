class TemplesController < ApplicationController
  before_action :authenticate_temple!, only: [:management]
  
  def show
    @temple = Temple.find(params[:id])
    @articles = @temple.articles
  end
  
  def index
    @temples = Temple.search(params[:search]).order(:name_kana)
  end
  
  def management
    @temple = Temple.find(params[:temple_id])
  end
  
end