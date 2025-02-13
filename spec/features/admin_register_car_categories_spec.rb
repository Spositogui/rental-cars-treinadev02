require 'rails_helper'

feature 'Admin register new Car Category' do
  scenario 'successfully' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome da categoria', with: 'Categoria A'
    fill_in 'Diária', with: 120.00
    fill_in 'Seguro', with: 75.00
    fill_in 'Seguro de terceiros', with: 30.00
    click_on 'Enviar'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content(120.00)
    expect(page).to have_content(75.00)
    expect(page).to have_content(30.00)
  end

  scenario 'failed' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_car_category_path

    fill_in 'Nome da categoria', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro', with: ''
    fill_in 'Seguro de terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be logged in' do 
    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be legged in to see register button' do
    visit car_categories_path

    expect(page).not_to have_link('Registrar nova categoria de carro')
    expect(current_path).to eq(new_user_session_path)
  end
end