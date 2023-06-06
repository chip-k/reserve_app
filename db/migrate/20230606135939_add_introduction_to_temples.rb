class AddIntroductionToTemples < ActiveRecord::Migration[6.1]
  def change
    add_column :temples, :introduction, :text
  end
end
