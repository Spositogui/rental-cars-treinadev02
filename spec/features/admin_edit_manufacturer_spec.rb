require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@test.com', password: '123456', 
                        role: :admin)
    Manufacturer.create!(name: 'Fiat')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
    expect(page).to have_content('Fabricante atualizado com sucesso.')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@test.com', password: '123456', 
                        role: :admin)
    Manufacturer.create!(name: 'Fiat')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'name must be unique' do
    user = User.create!(email: 'teste@test.com', password: '123456', 
                        role: :admin)
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'must be log in' do
    manufacturer = Manufacturer.create!(name: 'Fabricante A')
    
    visit edit_manufacturer_path(manufacturer)
    expect(current_path).to eq(new_user_session_path)
  end
end