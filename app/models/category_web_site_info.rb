class CategoryWebSiteInfo
  include ActiveModel::Model
  attr_accessor :category_name   # カテゴリテーブル
  attr_accessor :site_title,     # サイト情報テーブル
                :summary_text,
                :site_URL
  attr_accessor :scategory_names # サブカテゴリテーブル

  # バリデーション
  with_options presence: true do
    # カテゴリ
    validates :category_name
    # サイト情報
    validates :site_title,    length: { in: 0..200, message: 'is invalid. 100 characters max.' }
    validates :summary_text,  length: { in: 0..280, message: 'is invalid. 140 characters max.' }
    validates :site_URL,      format: { with: %r{\Ahttp://|\Ahttps://}, message: 'is invalid.' }
    # サブカテゴリ
    validates :scategory_names
  end
  # URLの一意性確認
  validate :sURL_must_be_unique
  # URLのリンクチェック
  validate :validate_url

  def save
    # カテゴリを保存し、変数categoryに代入する
    category = Category.find_by(category_name: category_name)
    if category.nil?
      category = Category.create(category_name: category_name)
    end
    # サブカテゴリの登録
    array_scategory =[]
    scategory_names.each do |scategory_name|
      sub_category = SubCategory.find_by(scategory_name: scategory_name)
      if sub_category.nil?
        sub_category = SubCategory.create(scategory_name: scategory_name)
      end
      array_scategory << sub_category.id
    end
    # サイト情報を保存する category_idには、変数categoryのidと指定する
    web_site_info = WebSiteInfo.create(site_title:  site_title,
                                          summary_text: summary_text,
                                          site_URL: site_URL,
                                          category_id: category.id)
    # 中間テーブルの登録
    array_scategory.each do |sub_category_id|
      SinfoScategory.create(web_site_info_id: web_site_info.id, sub_category_id: sub_category_id)
    end
  end

  private

  def sURL_must_be_unique
    if WebSiteInfo.exists?(site_URL: site_URL)
    # if WebSiteInfo.exists?(:site_URL)
        errors.add(:base, 'すでに登録されています。')
    end
  end

  def validate_url
    unless UrlChecker.check_url(site_URL)
      errors.add(:base, '提供されたURLは無効またはリンクが切れています。')
    end
  end
end