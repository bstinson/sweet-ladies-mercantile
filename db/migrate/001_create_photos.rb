class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :product_id
      t.string :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
