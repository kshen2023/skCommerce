class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new_products
    @products = Product.new_products.page(params[:page]).per(9)
  end

  def recently_updated
    @products = Product.recently_updated.page(params[:page]).per(9)
  end

  def search
    if params[:keyword].present?
      @products = Product.where("title LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                         .page(params[:page]).per(12)
    else
      @products = Product.none.page(params[:page]).per(12) # Return empty relation if no keyword
    end
    render 'index' # 渲染显示搜索结果的视图
  end

  def search_by_category
    category = Category.find(params[:category_id])
    if params[:keyword].present?
      @products = category.products.where("title LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
                                    .page(params[:page]).per(12)
    else
      @products = category.products.page(params[:page]).per(12) # Return all products in category if no keyword
    end
    render 'index' # 渲染显示搜索结果的视图
  end
end
