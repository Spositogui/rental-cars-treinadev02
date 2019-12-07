require 'rails_helper'

feature 'Admin edits car categories' do
  scenario 'successfully' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :admin)
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Categoria A'
    click_on 'Editar'
    fill_in 'Nome', with: 'Categoria C'
    fill_in 'Diária', with: 235.00
    fill_in 'Seguro', with: 70.00
    fill_in 'Seguro de terceiros', with: 32.25
    click_on 'Enviar'

    expect(page).to have_content('Categoria C')
    expect(page).to have_content(235.00)
    expect(page).to have_content(70.00)
    expect(page).to have_content(32.25)
  end

  scenario 'must fill in all field' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :admin)
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    login_as(user, scope: :user)
    visit car_categories_path
    click_on 'Categoria A'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: 235.00
    fill_in 'Seguro', with: ''
    fill_in 'Seguro de terceiros', with: 32.25
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'name must be unique' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :admin)
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)
    CarCategory.create!(name: 'Categoria B', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    login_as(user, scope: :user)
    visit car_categories_path
    click_on 'Categoria B'
    click_on 'Editar'
    fill_in 'Nome', with: 'Categoria A'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be log in' do
    car_category = CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    visit edit_car_category_path(car_category)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to see edit button' do 
    car_category = CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                                      third_party_insurance: 50.00)

    visit car_category_path(car_category)

    expect(page).not_to have_link('Editar')
    expect(current_path).to eq(new_user_session_path)
  end
end