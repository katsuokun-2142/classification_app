class CategoryWebSiteInfo
  include ActiveModel::Model
  attr_accessor :category_name
  attr_accessor :site_title,
                :summary_text,
                :site_URL

  # バリデーション
  with_options presence: true do
    # カテゴリ
    validates :category_name
    # サイト情報
    validates :site_title,    length: { in: 1..200, message: 'is invalid. 100 characters max.'}
    validates :summary_text,  length: { in: 1..280, message: 'is invalid. 140 characters max.'}
    validates :site_URL,      format: { with: /\Ahttp:\/\/|\Ahttps:\/\//, message: 'is invalid.' }
  end
  # 購入記録
  # validate :item_must_be_unique

  def save
    # カテゴリを保存し、変数categoryに代入する
    category = Category.create(category_name: category_name)
    # サイト情報を保存する category_idには、変数categoryのidと指定する
    web_site_infos = WebSiteInfo.create(site_title:  site_title,
                                          summary_text: summary_text,
                                          site_URL: site_URL,
                                          category_id: category.id)
  end

  private

  # def item_must_be_unique
  #   if Order.exists?(item_id: item_id)
  #     errors.add(:base, '商品はすでに売り切れです。')
  #   end
  # end
end