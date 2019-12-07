require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do 
    user = User.create!(email: 'test@test.com', password: '123456',
                        role: :admin)
    Subsidiary.create!(name: 'Filial A', cnpj: '00.000.111/0005-10',
                      address: 'Av. aveninda, nº500')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Filial A'
    click_on 'Deletar'

    expect(page).to have_no_link('Filial A')
  end

  scenario 'must be log in' do
    subsidiary = Subsidiary.create!(name: 'Filial A', cnpj: '00.000.111/0005-10',
                                    address: 'Av. aveninda, nº500')
    
    visit subsidiary_path(subsidiary)

    expect(current_path).to eq(new_user_session_path)
  end
end