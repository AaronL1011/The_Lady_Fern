class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.decimal :total_price

      t.timestamps
    end
  end
end
