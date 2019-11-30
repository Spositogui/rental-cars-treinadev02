require 'rails_helper'

feature 'Admin register a new subsidiary' do
  scenario 'successfully' do
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

  scenario 'failed' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome da Filial', with: ''
    fill_in 'CNPJ',	with: ''
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os campos.')
  end
end