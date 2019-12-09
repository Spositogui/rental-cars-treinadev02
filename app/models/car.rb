class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  validates :license_plate, presence: true, uniqueness: true,
                            format: {
                              with: /[a-zA-Z]{3}\-\d{4}/, 
                              message: 'Insira uma placa válida no seguinte formato: AAA-0000'}
  validates :color, :mileage, presence: true
end
