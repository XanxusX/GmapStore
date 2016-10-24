class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.text :description
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
