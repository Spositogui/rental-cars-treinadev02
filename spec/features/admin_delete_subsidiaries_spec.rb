require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do  
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.111/0005-10',
                      address: 'Av. aveninda, nº500')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial A'
    click_on 'Deletar'

    expect(page).to have_no_link('Filial A')
  end
end