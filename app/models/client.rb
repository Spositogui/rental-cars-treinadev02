class Client < ApplicationRecord
  validates :name, presence: true
  validates :document, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def description
    "#{name} - #{document}"
  end
end
