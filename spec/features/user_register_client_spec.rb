require 'rails_helper'

feature 'User register a customer' do 
  scenario 'successfully' do 
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
    visit new_client_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'cpf must be unique' do
    Client.create!(name: 'Alan Turing', cpf: '000.000.000-00', 
                  email: 'alan@gmail.com')

    visit clients_path
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Joyce'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'josi@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'email must be unique' do
    Client.create!(name: 'Alan Turing', cpf: '000.000.000-00', 
                  email: 'alan@gmail.com')

    visit clients_path
    click_on 'Cadastrar novo cliente'
    fill_in 'Nome', with: 'Joyce'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'alan@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end
end