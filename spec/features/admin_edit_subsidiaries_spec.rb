require 'rails_helper'

feature 'Admin edit subsidiaries' do 
  scenario 'successfuly' do
    Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial C'
    click_on 'Editar'

    fill_in 'Nome da Filial', with: 'Campus Code'
    fill_in 'CNPJ', with: '00.000.000/0005-10'
    fill_in 'Endereço', with: 'Av. Ruby, nº 222'
    click_on 'Enviar'

    expect(page).to have_content('Campus Code')
    expect(page).to have_content('00.000.000/0005-10')
    expect(page).to have_content('Av. Ruby, nº 222')
  end

  scenario 'failed' do 
    Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial C'
    click_on 'Editar'

    fill_in 'Nome da Filial', with: ''
    fill_in 'CNPJ', with: '00.000.000/0005-10'
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('É necessário preencher todos os campos.')
  end
end