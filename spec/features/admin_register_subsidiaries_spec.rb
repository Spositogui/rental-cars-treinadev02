require 'rails_helper'

feature 'Admin register a new subsidiary' do
  scenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '156321',
                        role: :admin)

    login_as(user, scope: :user)
    visit root_path 
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome da Filial', with: 'Filial A'
    fill_in 'CNPJ',	with: '00.000.000/0000-00'
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'
    
    expect(page).to have_content('Filial A')
    expect(page).to have_content('00.000.000/0000-00')
    expect(page).to have_content('Av. Ruby, nº 263')
  end

  scenario 'fields cant be blank' do
    user = User.create!(email: 'test@test.com', password: '156321',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_subsidiary_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'check for duplicity' do
    user = User.create!(email: 'test@test.com', password: '156321',
                        role: :admin)
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-00',
                      address: 'Av. Zelda, 2020')

    login_as(user, scope: :user)
    visit new_subsidiary_path
    fill_in 'Nome da Filial', with: 'Filial C'
    fill_in 'CNPJ',	with: '00.000.000/0000-00'
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'cnpj must be valid' do
    user = User.create!(email: 'test@test.com', password: '156321',
                        role: :admin)

    login_as(user, scope: :user)
    visit new_subsidiary_path
    fill_in 'Nome da Filial', with: 'Filial A'
    fill_in 'CNPJ',	with: '00jõao.000'
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be logged in' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to create new subsidiary' do
    visit subsidiaries_path

    expect(page).not_to have_link('Registrar nova filial')
    expect(current_path).to eq(new_user_session_path)
  end
end