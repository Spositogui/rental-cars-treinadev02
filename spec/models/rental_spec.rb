require 'rails_helper'

describe Rental do
  describe '.end_date_must_be_grater_than_start_date' do
    it 'success' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors).to be_empty
    end

    it 'end date less than start date' do 
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019')

      rental.valid?
      expect(rental.errors.full_messages).to include('End date deve ser maior que data de ínicio')
    end

    it 'end date equal than start date' do
      rental = Rental.new(start_date: '09/12/2019', end_date: '09/12/2019')

      rental.valid?

      expect(rental.errors.full_messages).to include('End date deve ser maior que data de ínicio')
    end

    it 'start date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: nil, end_date: '10/12/2019', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_messages).to include("Start date can't be blank")
    end

    xit 'start date cant be blank' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: '', end_date: '10/12/2019', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_message).to include('Start date deve ser preenchida')
    end

    it 'end date must exist' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: nil, client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_messages).to include("End date can't be blank")
    end

    it 'end date cant be blank' do
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '', client: client,
                          car_category: car_category)

      rental.valid?

      expect(rental.errors.full_messages).to include("End date can't be blank")
    end
  end

  describe '.start date must be grater than current day' do
    it 'successfully' do 
      client = Client.new(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                          document: '743.341.870-99')
      car_category = CarCategory.new(name: 'A', daily_rate: 30, car_insurance: 30,
                                    third_party_insurance: 30)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now,
                          client: client, car_category: car_category)

      rental.valid?
      
      expect(rental.errors).to be_empty
    end

    it 'start date less than current day' do
      rental = Rental.new(start_date: 1.day.ago)

      rental.valid?

      expect(rental.errors.full_messages).to include('Start date deve ser maior que a data atual')
    end

    it 'start date must exist' do
      rental = Rental.new(start_date: nil, end_date: 2.days.from_now)

      rental.valid?

      expect(rental.errors.full_messages).to include("Start date can't be blank")
    end

    it 'start date cant be blank' do
      rental = Rental.new(start_date: '')

      rental.valid?

      expect(rental.errors.full_messages).to include("Start date can't be blank")
    end
  end
end
