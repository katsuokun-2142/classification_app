class CreateWebSiteInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :web_site_infos do |t|
      t.text        :site_title,   null: false,                     comment: 'サイトタイトル'
      t.text        :summary_text, null: false,                     comment: '要約文'
      t.text        :site_URL,     null: false,                     comment: 'サイトURL'
      t.references  :category,     null: false, foreign_key: true,  comment: 'カテゴリ'
      t.timestamps
    end
  end
end
