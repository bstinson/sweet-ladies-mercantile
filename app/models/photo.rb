class Photo < ActiveRecord::Base

  acts_as_fleximage do
    image_directory 'public/images/uploaded'
    use_creation_date_based_directories false
    image_storage_format :jpg
    
    preprocess_image do |image|
      image.resize '800x600'
    end
  end
  
  belongs_to :product
  belongs_to :category
    
end
