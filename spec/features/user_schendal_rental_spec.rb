require 'rails_helper'

feature 'user schedule rental' do
  scenario 'successfullly' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                            document: '743.341.870-99')
    car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30,
                                      third_party_insurance: 30)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de inicio', with: 1.day.from_now
    fill_in 'Data de término', with: 2.days.from_now
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select car_category.name, from: 'Categoria do carro'
    click_on 'Enviar'

    expect(page).to have_content(1.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content(2.days.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.document)
    expect(page).to have_content('Categoria')
    expect(page).to have_content(car_category.name)
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                            document: '743.341.870-99')
    car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30,
                                      third_party_insurance: 30)

    login_as(user, scope: :user)
    visit rentals_path
    click_on 'Agendar locação'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
  end

  scenario 'and start date must be less to end date' do
    user = User.create!(email: 'test@gmail.com', password: '123456',
                        role: :employee)
    client = Client.create!(name: 'Fulano Sicrano', email: 'fulado@outlook.com',
                            document: '743.341.870-99')
    car_category = CarCategory.create!(name: 'A', daily_rate: 30, car_insurance: 30,
                                      third_party_insurance: 30)

    login_as(user, scope: :user)
    visit rentals_path
    click_on 'Agendar locação'
    fill_in 'Data de inicio', with: 2.days.from_now
    fill_in 'Data de término', with: 1.day.from_now
    select "#{client.name} - #{client.document}", from: 'Cliente'
    select car_category.name, from: 'Categoria do carro'
    click_on 'Enviar'

    expect(page).to have_content('End date deve ser maior que data de ínicio')
  end

  scenario 'and must be logged in' do 
    visit rentals_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be logged in to see the link to rentals' do
    visit root_path

    expect(page).not_to have_link('Locações')
  end
end