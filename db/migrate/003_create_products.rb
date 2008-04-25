class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title, :null => 'false'
      t.string :description
      t.string :sizes
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :category_id, :null => 'false'
      t.string :sub_cat
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
