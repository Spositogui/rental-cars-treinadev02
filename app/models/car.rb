class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_many :car_rentals
  has_many :rentals, through: :car_rentals

  validates :license_plate, presence: true, uniqueness: true,
                            format: {
                              with: /[a-zA-Z]{3}\-\d{4}/, 
                              message: 'Insira uma placa válida no seguinte formato: AAA-0000'}
  validates :color, presence: true
  validates :mileage, numericality: {
          greater_than_or_equal_to: 0, 
          message: 'Quilometragem não pode ser menor que zero'}

  enum status: {available: 0, unavailable: 5}
          
  def name
    "#{car_model.name} - #{license_plate}"
  end

  def price
    car_model.car_category.daily_rate +
    car_model.car_category.third_party_insurance +
    car_model.car_category.car_insurance
  end
end
