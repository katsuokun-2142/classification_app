class CreateSinfoScategories < ActiveRecord::Migration[7.0]
  def change
    create_table :sinfo_scategories do |t|
      t.references  :web_site_info, null: false, foreign_key: true, comment: 'サイト情報'
      t.references  :sub_category,  null: false, foreign_key: true, comment: 'サブカテゴリ'
      t.timestamps
    end
  end
end
