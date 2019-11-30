require 'rails_helper'

feature 'Admin register new Car Category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome da categoria', with: 'Categoria A'
    fill_in 'Diária', with: 120.00
    fill_in 'Seguro', with: 75.00
    fill_in 'Seguro de terceiros', with: 30.00
    click_on 'Enviar'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content(120.00)
    expect(page).to have_content(75.00)
    expect(page).to have_content(30.00)
  end

  scenario 'failed' do
    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome da categoria', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro', with: ''
    fill_in 'Seguro de terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nenhum campo pode permancer vazio!')
  end
end