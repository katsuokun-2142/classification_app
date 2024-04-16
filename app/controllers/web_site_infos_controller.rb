class WebSiteInfosController < ApplicationController
  def index
  end

  def new
    @category_web_site_info = CategoryWebSiteInfo.new
  end

  def create
    # URLをチェック
    if UrlChecker.check_url(params.require(:category_web_site_info)[:site_URL]) == false
      @category_web_site_info = CategoryWebSiteInfo.new
      @category_web_site_info.errors.add(:base, 'URLのリンクが切れています。')
      render :new, status: :unprocessable_entity
      return
    end

    @category_web_site_info = CategoryWebSiteInfo.new(category_web_site_info_params)
    if @category_web_site_info.valid?
      # カテゴリとサイト情報の登録
      @category_web_site_info.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def category_web_site_info_params
    # 外部APIから取得したデータや、その他のソースからのデータを含む新しいパラメータを作成
    str_URL = params.require(:category_web_site_info)[:site_URL]
    chatGPT = ChatGptService.new
    hash_summary = chatGPT.chat(str_URL)
    additional_params = ActionController::Parameters.new({
      additional_params: {
        category_name: hash_summary[:category],
        site_title: ScrapingHtml.get_title(str_URL),
        summary_text: hash_summary[:summary_text],
        scategory_names: hash_summary[:sub_categories]
      }
    })
    # 新しいパラメータをrequireおよびpermitして、安全に使用できるようにする
    permitted_additional_params = additional_params.require(:additional_params).permit(:category_name, :site_title, :summary_text, scategory_names: [])

    # 既存のparamsに新しいパラメータをマージ
    params.require(:category_web_site_info).permit(:site_URL).merge(permitted_additional_params)
  end
end
