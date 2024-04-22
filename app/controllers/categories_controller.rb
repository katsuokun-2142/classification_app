class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:web_site_infos).where.not(web_site_infos: { id: nil }).order("category_name ASC").page(params[:page])
  end
end
