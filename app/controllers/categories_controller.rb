class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.sub_categories.joins(:products).select('products.*').page(params[:page]).per(12)
  end
end
