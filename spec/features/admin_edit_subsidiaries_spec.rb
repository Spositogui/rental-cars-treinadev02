require 'rails_helper'

feature 'Admin edit subsidiaries' do 
  scenario 'successfuly' do
    user = User.create!(email: 'test@hotmail.com',password: '123456',
                        role: :admin)
    Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    login_as(user, scope: :user)
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
    user = User.create!(email: 'test@hotmail.com',password: '123456',
                        role: :admin)
    Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Filial C'
    click_on 'Editar'

    fill_in 'Nome da Filial', with: ''
    fill_in 'CNPJ', with: '00.000.000/0005-10'
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'must be logged in' do
    subsidiary = Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    visit edit_subsidiary_path(subsidiary)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to see edit button' do
    subsidiary = Subsidiary.create!(name: 'Filial C', cnpj: '00.000.000/0000-02',
                      address: 'Av. Rails, nº 523')

    visit subsidiary_path(subsidiary)

    expect(page).not_to have_link('Editar')
    expect(current_path).to eq(new_user_session_path)
  end
end