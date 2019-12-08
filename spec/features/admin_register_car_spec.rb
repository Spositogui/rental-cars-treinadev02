require 'rails_helper'

feature 'Admin register a new car' do
   scenario 'successfully' do
      user = User.create!(email: 'test@ts.com', password:  '124563',
                          role: :admin)
      manufacturer = Manufacturer.create!(name: 'Chevrolet')
      car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                        car_insurance: 100.00,
                                        third_party_insurance: 50.00)
      CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                      motorization: '1.0', manufacturer: manufacturer,
                      car_category: car_category)
      Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                        address: 'Av. Rails, nº 523')
      
      login_as(user, scope: :user)
      visit root_path
      click_on 'Carros'
      click_on 'Registrar novo carro'

      select 'Onix', from: 'Modelo do carro'
      fill_in 'Placa', with: 'AAA-0000'
      fill_in 'Cor', with: 'Preto'
      fill_in 'Quilometragem', with: '1000'
      select 'Filial A', from: 'Filial'
      click_on 'Enviar'

      expect(page).to have_content('Placa: AAA-0000')
      expect(page).to have_content('Cor: Preto')
      expect(page).to have_content('Modelo de carro: Onix')
      expect(page).to have_content('Quilometragem: 1000')
      expect(page).to have_content('Filial: Filial A')
   end

   scenario 'fields must be fill in' do
    user = User.create!(email: 'test@ts.com', password:  '124563',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_car_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
   end

   scenario 'license plate must be unique' do
    user = User.create!(email: 'test@ts.com', password:  '124563',
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
    Car.create!(license_plate: 'AAA-0000', color: 'Preto', car_model: car_model,
                mileage: 1000, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit new_car_path
    fill_in 'Placa', with: 'AAA-0000'
    fill_in 'Cor', with: 'Preto'
    select 'Onix', from: 'Modelo do carro'
    fill_in 'Quilometragem', with: '1000'
    select 'Filial A', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
   end

   scenario 'license plate must be valid' do
    user = User.create!(email: 'test@ts.com', password:  '124563',
                       role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                    motorization: '1.0', manufacturer: manufacturer,
                    car_category: car_category)
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    login_as(user, scope: :user)
    visit new_car_path
    fill_in 'Placa', with: 'A20-0000'
    fill_in 'Cor', with: 'Preto'
    select 'Onix', from: 'Modelo do carro'
    fill_in 'Quilometragem', with: '1000'
    select 'Filial A', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
   end

   scenario 'must be logged in' do
     visit new_car_path

     expect(current_path).to eq(new_user_session_path)
   end

   scenario 'must be logged in to register new car' do
     visit cars_path

     expect(page).not_to have_content('Registrar novo carro')
     expect(current_path).to eq(new_user_session_path)
   end
end

=begin
Eu, usuário administrador,
Gostaria de cadastrar um novo carro para a frota de uma filial
Para que esse carro possa ser alugado no futuro pelos clientes.

Carro (Car):

Placa (license_plate): string
Cor (color): string
Car Model: object
Quilometragem (mileage): integer
Subsidiary: objec

regex placa:[a-zA-Z]{3}\-\d{4}
=end

