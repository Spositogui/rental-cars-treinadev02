class Client < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def client_info
    "Nome: #{name}, CPF: #{cpf}"
  end
end
