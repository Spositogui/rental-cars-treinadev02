require 'rails_helper'

feature 'Admin View Car Categories list' do
  scenario 'successfully' do 
    CarCategory.create!(name: 'Categoria A', daily_rate: 125.00, car_insurance: 50.00,
                          third_party_insurance: 26.00)

    visit root_path
    click_on 'Categorias de Carro'
    click_on 'Categoria A'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content(125.00)
    expect(page).to have_content(50.00)
    expect(page).to have_content(26.00)
    expect(page).to have_content('Voltar')
  end

  scenario 'more than one car category' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 125.00, car_insurance: 50.00,
                          third_party_insurance: 25.00)
    CarCategory.create!(name: 'Categoria B', daily_rate: 250.00, car_insurance: 150.00,
                          third_party_insurance: 75.00)

    visit car_categories_path

    expect(page).to have_link('Categoria A')
    expect(page).to have_link('Categoria B')
  end

  scenario 'back to home page' do
    CarCategory.create!(name: 'Categoria A', daily_rate: 125.00, car_insurance: 50.00,
                          third_party_insurance: 25.00)

    visit car_categories_path
    click_on 'Categoria A'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'without any car categories - failed' do
    visit car_categories_path

    expect(page).to have_content('Nenhuma categoria de carro cadastrada '\
                                'no sistema.')
  end
end