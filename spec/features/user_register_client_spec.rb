require 'rails_helper'

feature 'User register a customer' do 
  scenario 'successfully' do 
    user = User.create!(email: 'test@test.com', password: '132564',
                        role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Ada Lovelace'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'ada@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Ada Lovelace')
    expect(page).to have_content('000.000.000-00')
    expect(page).to have_content('ada@gmail.com')
  end

  scenario 'fields cant be blank' do
    user = User.create!(email: 'test@test.com', password: '132564',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_client_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'cpf must be unique' do
    Client.create!(name: 'Alan Turing', cpf: '000.000.000-00', 
                  email: 'alan@gmail.com')
    user = User.create!(email: 'test@test.com', password: '132564',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'Joyce'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'josi@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'email must be unique' do
    user = User.create!(email: 'test@test.com', password: '132564',
                        role: :admin)
    Client.create!(name: 'Alan Turing', cpf: '000.000.000-00', 
                  email: 'alan@gmail.com')
        
    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'Joyce'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'alan@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be logged in' do
    visit new_client_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to access Clients' do
    visit root_path

    expect(page).not_to have_link('Clientes')
  end
end