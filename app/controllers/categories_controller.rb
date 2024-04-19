class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:web_site_infos).order("category_name ASC").page(params[:page])
    # @categories = Category.includes(:category).includes(:sub_categories).order("category_name ASC").page(params[:page])
  end
end
