require 'rails_helper'

feature 'Admin edits car models' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                                      car_insurance: 100.00,
                                      third_party_insurance: 50.00)
    model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
                            motorization: '1.0', manufacturer: manufacturer,
                            car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carro'
    click_on model.name
    click_on 'Editar'

    fill_in 'Nome', with: 'Modelo C'
    fill_in 'Ano', with: '2021'
    click_on 'Enviar'

    expect(page).to have_content('Modelo editado com sucesso')
    expect(page).to have_css('h1', text: 'Modelo C')
    expect(page).to have_content('Ano: 2021')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end

  scenario 'all fiels must be fill in' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                        car_insurance: 100.00,
                        third_party_insurance: 50.00)
    model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
              motorization: '1.0', manufacturer: manufacturer,
              car_category: car_category)

    login_as(user, scope: :user)
    visit car_models_path
    click_on model.name
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be log in' do
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_category = CarCategory.create!(name: 'A', daily_rate: 250.00, 
                        car_insurance: 100.00,
                        third_party_insurance: 50.00)
    model = CarModel.create!(name: 'Onix', year: 2020, fuel_type: 'Flex',
              motorization: '1.0', manufacturer: manufacturer,
              car_category: car_category)

    visit edit_car_model_path(model)

    expect(current_path).to eq(new_user_session_path)
  end
end