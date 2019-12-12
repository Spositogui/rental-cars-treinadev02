class CarCategory < ApplicationRecord
  has_many :car_models
  has_many :cars, through: :car_models
  
  validates :name, :daily_rate, :car_insurance,
            :third_party_insurance, presence: true

  validates :name, uniqueness: true

  def price
    #TODO method price for calling in car
  end
end
