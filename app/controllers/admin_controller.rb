class AdminController < ApplicationController
before_filter :authenticate

  def index
    @products = Product.find(:all)
    @categories = Category.find(:all)
  end
  
  def view_categories
    if flash[:notice] == nil
      flash[:notice] = "Here are the categories that you can use to sort your products into."
    end
    @categories = Category.find(:all)
  end
  
  def add_category
    if request.post? and params[:category]
      @category = Category.new(params[:category])
      if @category.save
        flash[:notice] = "Category has been added!"
        redirect_to :action => 'view_categories'
      end
    else
      flash[:notice] = "Here you can add a category for your site."
    end
  end
  
  def view_products
    if flash[:notice] == nil
      flash[:notice] = "Here is a list of all of the products available on your site."
    end  
    @products = Product.find(:all)
  end
  
  def add_product
    if request.post? and params[:product]
      @product = Product.new(params[:product])
      @categories = Category.find(:all)
      if @product.save
        flash[:notice] = "Product has been added!"
        redirect_to :action => 'edit_product', :id => @product
      end
    else
      @categories = Category.find(:all)
    end
    if flash[:notice] == nil
      flash[:notice] = "Here you can add a product for your site."
    end
  end
  
  def edit_product
    @images = Photo.find_all_by_product_id(params[:id])
    if request.post? and params[:product]
      @product = Product.find_by_id(params[:id])
      if @product.update_attributes(params[:product])
        flash[:notice] = "Product has been updated!"
        redirect_to :action => 'edit_product', :id => @product
      end
    else
      @product = Product.find_by_id(params[:id])
      @categories = Category.find(:all)
      if flash[:notice] == nil
        flash[:notice] = "Here you can view and edit your product."
      end
    end
  end
  
  def upload_image
    if request.post? and params[:photo]
      @photo = Photo.new(params[:photo])
      if @photo.save
        redirect_to :action => 'edit_product', :id => @photo.product_id
      end
    else
      @product = Product.find_by_id(params[:id])
      render :layout => 'ajax'
    end
  end
  
  def upload_category_image
    if request.post? and params[:photo]
      @photo = Photo.new(params[:photo])
      if @photo.save
        redirect_to :action => 'edit_category', :id => @photo.category_id
      end
    else
      @category = Category.find_by_id(params[:id])
      render :layout => 'ajax'
    end
  end
  
  def edit_category
    @category = Category.find_by_id(params[:id])
    @images = Photo.find_all_by_category_id(params[:id])
    if request.post? and params[:category]
      if @category.update_attributes(params[:category])
        flash[:notice] = "Category Updated!"
        redirect_to :action => "edit_category", :id => @category.id
      end
    end
    if flash[:notice] == nil
      flash[:notice] = "Here you can edit information concerning your category."  
    end
  end
  
  def remove_category
    @category = Category.find_by_id(params[:id])
    @new_category = Category.find(:first)
    @products = Product.find_all_by_category_id(@category.id)
    if @category.destroy
      for product in @products
        product.update_attributes(:category_id => @new_category.id)
      end  
      flash[:notice] = "Category Removed"
      redirect_to :action => 'view_categories'
    end
  end

  def remove_product
    @product = Product.find_by_id(params[:id])
    if @product.destroy
      flash[:notice] = "Product Removed!"
      redirect_to :action => 'view_products'
    end
  end

  def remove_image
    @photo = Photo.find_by_id(params[:id])
    if @photo.destroy
      flash[:notice] = "Image Removed!"
      if @photo.product_id.nil?
        redirect_to :action => 'edit_category', :id => @photo.category_id
      else
        redirect_to :action => 'edit_product', :id => @photo.product_id
      end  
    end
  end
  
  protected
    
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "sweet"
      end
    end      
end