class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string  :zip_code, null: false
      t.integer :shipping_from_id, null: false
      t.string  :municipality, null: false
      t.string  :house_number, null: false
      t.string  :building_name
      t.string  :phone_number, null: false
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
