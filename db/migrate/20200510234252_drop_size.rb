class DropSize < ActiveRecord::Migration[6.0]
  def change
    drop_table :sizes
  end
end
