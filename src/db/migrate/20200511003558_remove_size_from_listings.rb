class RemoveSizeFromListings < ActiveRecord::Migration[6.0]
  def change

    remove_column :listings, :size, :string
  end
end
