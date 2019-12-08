class CarModel < ApplicationRecord
  validates :name, :year, :fuel_type, :motorization, presence: true
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars
end
