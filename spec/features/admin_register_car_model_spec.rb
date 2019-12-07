require 'rails_helper'

feature 'Admin register car model' do 
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'A', daily_rate: 250.00, car_insurance: 100.00,
                        third_party_insurance: 50.00)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Modelo registrado com sucesso')
    expect(page).to have_css('h1', text: 'Onix')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end
end