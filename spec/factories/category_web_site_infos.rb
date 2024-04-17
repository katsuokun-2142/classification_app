FactoryBot.define do
  Faker::Config.locale = :ja
  factory :category_web_site_info do
    # address = Gimei.address
    # カテゴリテーブル
    category_name       { Faker::Job.field }
    # サイト情報テーブル
    site_title          { Faker::Lorem.sentence }
    summary_text        { Faker::Lorem.sentence }
    site_URL            { 'https://www.google.com/' } # Faker::Internet.url
    # サブカテゴリテーブル
    scategory_names      { Faker::Lorem.words(number: 3) }

  end
end
