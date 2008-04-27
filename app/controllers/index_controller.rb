class IndexController < ApplicationController
  
  def index
    @categories = Category.find(:all)
  end

  def view_category
    @categories = Category.find(:all)
    @category = Category.find_by_id(params[:id])
    @products = Product.find_all_by_category_id(params[:id], :order => "sub_cat")
    @sections = Product.find_all_by_category_id(params[:id], :select => "DISTINCT sub_cat")
  end
  
  def view_product
    @categories = Category.find(:all)
    @product = Product.find_by_id(params[:id])
    @image = Photo.find_by_product_id(params[:id])
  end
  
/ These controllers are used to display and render images properly./  
  def thumb
    @photo = Photo.find_by_id(params[:id])
  end
  
  def cat
    @photo = Photo.find_by_id(params[:id])
  end 
  
  def view
    @photo = Photo.find_by_id(params[:id])
  end 
end
