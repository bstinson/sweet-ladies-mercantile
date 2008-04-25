module AdminHelper
  def display_images(product_id)
    @image = Photo.find_by_product_id(product_id)
    if @image.nil?
    else
      link_to(image_tag("/index/thumb/" + @image.id.to_s + ".jpg"), :action => 'edit_product', :id => @image.product_id)
    end    
  end  
end
