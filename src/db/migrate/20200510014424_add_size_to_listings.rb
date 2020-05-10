class AddSizeToListings < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :size, null: false, foreign_key: true, :default => 1
  end
end
