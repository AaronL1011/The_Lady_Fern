class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :billing_street_address
      t.string :billing_suburb
      t.string :billing_state
      t.string :billing_post_code
      t.string :shipping_street_address
      t.string :shipping_suburb
      t.string :shipping_state
      t.string :shipping_post_code

      t.timestamps
    end
  end
end
