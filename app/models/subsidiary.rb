class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
end
