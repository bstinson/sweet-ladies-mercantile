class AddCodeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :code, :integer
  end

  def self.down
    remove_column :products, :code
  end
end
