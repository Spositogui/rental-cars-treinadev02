class CreateCarCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :car_categories do |t|
      t.string :name
      t.decimal :daily_rate, precision: 8, scale: 2
      t.decimal :car_insurance, precision: 8, scale: 2
      t.decimal :third_party_insurance, precision: 8, scale: 2

      t.timestamps
    end
  end
end
