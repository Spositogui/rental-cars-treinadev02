require 'rails_helper'

feature 'Admin edits car categories' do
  scenario 'successfully' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Categoria A'
    click_on 'Editar'
    fill_in 'Nome', with: 'Categoria C'
    fill_in 'Diária', with: 235.00
    fill_in 'Seguro', with: 70.00
    fill_in 'Seguro de terceiros', with: 32.25
    click_on 'Enviar'

    expect(page).to have_content('Categoria C')
    expect(page).to have_content(235.00)
    expect(page).to have_content(70.00)
    expect(page).to have_content(32.25)
  end

  scenario 'must fill in all field' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    visit car_categories_path
    click_on 'Categoria A'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: 235.00
    fill_in 'Seguro', with: ''
    fill_in 'Seguro de terceiros', with: 32.25
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'name must be unique' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)
    CarCategory.create!(name: 'Categoria B', daily_rate: 250.00, car_insurance: 100.00, 
                        third_party_insurance: 50.00)

    visit car_categories_path
    click_on 'Categoria B'
    click_on 'Editar'
    fill_in 'Nome', with: 'Categoria A'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end
end