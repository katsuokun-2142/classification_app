class CreateSubCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_categories do |t|
      t.text        :scategory_name,  null: false,  comment: 'サブカテゴリ名'
      t.timestamps
    end
  end
end
