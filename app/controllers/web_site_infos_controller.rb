class WebSiteInfosController < ApplicationController
  def index
  end

  def new
    @category_web_site_info = CategoryWebSiteInfo.new
  end

  def create
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
    additional_params = ActionController::Parameters.new({
      additional_params: {
        category_name: 'APIから取得したカテゴリ名',
        site_title: ScrapingHtml.get_title(params.require(:category_web_site_info)[:site_URL]),
        summary_text: 'APIから取得した要約テキスト'
      }
    })
    # 新しいパラメータをrequireおよびpermitして、安全に使用できるようにする
    permitted_additional_params = additional_params.require(:additional_params).permit(:category_name, :site_title, :summary_text)

    # 既存のparamsに新しいパラメータをマージ
    params.require(:category_web_site_info).permit(:site_URL).merge(permitted_additional_params)
  end
end
