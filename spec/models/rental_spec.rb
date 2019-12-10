require 'rails_helper'

describe Rental do
  describe '.end_date_must_be_grater_than_start_date' do
    it 'success' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '10/12/2019', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors).to be_empty
    end

    it 'end date less than start date' do 
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019')

      rental.valid?

      expect(rental.errors.full_messages).to include('End date deve ser maior que data de ínicio')
    end

    xit 'end date equal than start date' do
    end

    xit 'start date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          cpf: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: nil, end_date: '10/12/2019', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_message).to eq(["Incluir mensagem"])
    end

    xit 'start date cant be blank' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          cpf: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: '', end_date: '10/12/2019', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_message).to eq(["Incluir mensagem"])
    end

    xit 'end date must exist' do
    end
  end
end
