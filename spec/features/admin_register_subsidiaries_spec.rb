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

  scenario 'fields cant be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'check for duplicity' do
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-00',
                      address: 'Av. Zelda, 2020')

    visit subsidiaries_path
    click_on 'Registrar nova filial'
    fill_in 'Nome da Filial', with: 'Filial C'
    fill_in 'CNPJ',	with: '00.000.000/0000-00'
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'cnpj must be valid' do
    visit subsidiaries_path
    click_on 'Registrar nova filial'
    fill_in 'Nome da Filial', with: 'Filial A'
    fill_in 'CNPJ',	with: '00jõao.000'
    fill_in 'Endereço', with: 'Av. Ruby, nº 263'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end
end

=begin
Eu, usuário administrador,
Gostaria que o sistema validasse que uma mesma filial não 
seja cadastrada duas vezes e que uma filial só seja cadastrada
com um CNPJ válido,
Para evitar cadastros indevidos na base de dados.
=end