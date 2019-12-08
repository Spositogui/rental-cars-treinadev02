class Subsidiary < ApplicationRecord
  has_many :cars
  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true, 
            format: { 
              with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/,
              message: "only allow numbers,'.', '/', and '-'"
            }
  validates :address, presence: true
end
