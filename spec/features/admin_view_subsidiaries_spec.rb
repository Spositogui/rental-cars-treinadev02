require 'rails_helper'

feature ' Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-00',
                      address: 'Av. Ruby, 263')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial A'

    expect(page).to have_content('Filial A')
    expect(page).to have_content('00.000.000/0000-00')
    expect(page).to have_content('Av. Ruby, 263')
    expect(page).to have_link('Voltar')
  end

  scenario 'more than one subsidiary' do
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-00',
                      address: 'Av. Ruby, 263')
    Subsidiary.create!(name: 'Filial B', cnpj: '00.000.000/0000-01',
                      address: 'Av. Rails, 600')
                      

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Filial A')
    expect(page).to have_link('Filial B')
  end

  scenario 'back to home page' do
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.000/0000-00',
                      address: 'Av. Ruby, 263')

    visit subsidiaries_path
    click_on 'Filial A'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'without any subsidiary -failed' do 
    visit subsidiaries_path

    expect(page).to have_content('Nenhuma filial cadastrada no sistema.')
  end
end