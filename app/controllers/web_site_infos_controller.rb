class WebSiteInfosController < ApplicationController
  before_action :validate_url, only: [:create]
  def index
    # @web_site_infos = WebSiteInfo.includes(:category).all
    @web_site_infos = WebSiteInfo.includes(:category).includes(:sub_categories).order("created_at DESC").page(params[:page])
  end

  def new
    @category_web_site_info = CategoryWebSiteInfo.new
  end

  def create
    @category_web_site_info = CategoryWebSiteInfo.new(category_web_site_info_params)
    if @category_web_site_info.valid?
      # カテゴリとサイト情報の登録
      @category_web_site_info.save
      # redirect_to root_path
      redirect_to root_path, notice: 'サイト情報が正常に登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    web_site_info = WebSiteInfo.find(params[:id])
    web_site_info.destroy
  end

  private

  def category_web_site_info_params
    params.require(:category_web_site_info).permit(:site_URL).merge(additional_params)
  end

  def validate_url
    site_url = params.require(:category_web_site_info)[:site_URL]
    unless UrlChecker.check_url(site_url)
      redirect_to new_web_site_info_path, alert: '提供されたURLは無効またはリンクが切れています。'
    end
  rescue => e
    Rails.logger.error "URL validation error: #{e.message}"
    redirect_to new_web_site_info_path, alert: 'URLの検証中にエラーが発生しました。'
  end

  def additional_params
    # ここで外部APIやScrapingHtmlからデータを取得する処理を実装
    str_URL = params.require(:category_web_site_info)[:site_URL]
    chatGPT = ChatGptService.new
    hash_summary = chatGPT.chat(str_URL)
    {
      category_name: hash_summary[:category],
      site_title: ScrapingHtml.get_title(str_URL),
      summary_text: hash_summary[:summary_text],
      scategory_names: hash_summary[:sub_categories]
    }
  rescue => e
    Rails.logger.error "Additional params error: #{e.message}"
    {} # 失敗した場合は空のハッシュを返して、処理を続行
  end
end
