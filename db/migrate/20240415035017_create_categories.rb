class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string      :category_name,  null: false,  comment: 'カテゴリ名'
      t.timestamps
    end
  end
end
