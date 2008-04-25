class Product < ActiveRecord::Base
  has_one :image
  belongs_to :category
  
  validates_presence_of :title
  validates_presence_of :code  
end
