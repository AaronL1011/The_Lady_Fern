class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.boolean :in_stock
      t.string :size
      t.image :image
      t.text :description

      t.timestamps
    end
  end
end
