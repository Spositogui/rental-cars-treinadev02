require 'rails_helper'

feature  'Admin edit cars' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    car_model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                                motorization: '1.0', manufacturer: manufacturer,
                                car_category: car_category)
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                                    address: 'Av. Rails, nº 523')
    Subsidiary.create!(name: 'Jorelzin Cars', cnpj: '00.000.000/0000-03',
                      address: 'Av. Rails, nº 523')
    car = Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                      mileage: 1000, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on car.car_model.name
    click_on 'Editar'

    fill_in 'Cor', with: 'Prata' 
    fill_in 'Quilometragem', with: '0'
    select 'Jorelzin Cars', from: 'Filial'
    click_on 'Enviar'
    
    expect(current_path).to eq(car_path(car))
    expect(page).to have_content('Cor: Prata')
    expect(page).to have_content('Quilometragem: 0')
    expect(page).to have_content('Filial: Jorelzin Cars')
    expect(page).to have_link('Voltar')
  end

  scenario 'all the fields must be fill in' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    car_model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                                motorization: '1.0', manufacturer: manufacturer,
                                car_category: car_category)
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                                    address: 'Av. Rails, nº 523')
    car = Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                      mileage: 1000, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit edit_car_path(car)

    fill_in 'Placa', with: ''
    select '', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'and license plate must be valid' do 
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    car_model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                                motorization: '1.0', manufacturer: manufacturer,
                                car_category: car_category)
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                                    address: 'Av. Rails, nº 523')
    car = Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                      mileage: 1000, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit edit_car_path(car)

    fill_in 'Placa', with: '50B-BBcd'
    click_on 'Enviar'

    expect(page).to have_content('Insira uma placa válida no seguinte formato: AAA-0000')
  end

  scenario 'and must be logged in' do
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    car_model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                                motorization: '1.0', manufacturer: manufacturer,
                                car_category: car_category)
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                                    address: 'Av. Rails, nº 523')
    car = Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                      mileage: 1000, subsidiary: subsidiary)
    
    visit edit_car_path(car)
    
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be logged in to see edit link' do
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    car_model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                                motorization: '1.0', manufacturer: manufacturer,
                                car_category: car_category)
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                                    address: 'Av. Rails, nº 523')
    car = Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                      mileage: 1000, subsidiary: subsidiary)
    
    
    visit car_path(car)

    expect(page).not_to have_link('Editar')
    expect(current_path).to eq(new_user_session_path)
  end
end

