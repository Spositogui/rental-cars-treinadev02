class CreateCarModels < ActiveRecord::Migration[5.2]
  def change
    create_table :car_models do |t|
      t.string :name
      t.integer :year
      t.string :fuel_type
      t.string :motorization
      t.references :manufacturer, foreign_key: true

      t.timestamps
    end
  end
end
