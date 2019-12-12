class CreateCarRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :car_rentals do |t|
      t.references :car, foreign_key: true
      t.references :rental, foreign_key: true
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
