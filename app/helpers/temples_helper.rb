module TemplesHelper
  
  #ユーザー検索フォームとボタンを表示
  def user_search
    search_field = text_field_tag(:search, params[:search], class: "form-control", placeholder: "名前を入力してください")
    search_button = button_tag(type: "submit", class: "btn btn-outline-primary", id: "button-addon2") do
      content_tag(:i, "", class: "fas fa-search") + "検索"
    end
    search_field + search_button
  end
  
end