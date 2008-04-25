module IndexHelper
  def category_image
    @image = Photo.find_by_category_id(@category.id)
    if !@image.nil?
      render :partial => 'main_image', :locals => {:image => @image}
    end  
  end

  def product_image(id, title)
    @image = Photo.find_by_product_id(id)
    if !@image.nil?
      link_to(image_tag("/index/thumb/" + @image.id.to_s + ".jpg", :alt => title), :action => "view_product", :id => id)
    end  
  end  
end
