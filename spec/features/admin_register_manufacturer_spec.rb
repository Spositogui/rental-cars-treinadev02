require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@test.com', password: '123456')

    login_as(user, scope: :user)
    visit new_manufacturer_path
    #fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'and name must be unique' do
    user = User.create!(email: 'teste@test.com', password: '123456')
    Manufacturer.create!(name: 'Fiat')
    
    login_as(user, scope: :user)
    visit new_manufacturer_path
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and must be logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq(new_user_session_path)
  end
end