class CreateListingsPurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :listings_purchases do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
