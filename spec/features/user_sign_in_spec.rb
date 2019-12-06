require 'rails_helper'

feature 'user sign in' do
  scenario 'succesfully' do
    user = User.create!(email: 'spositogui@example.com', password: 'abc45678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in "Senha", with: user.password
    within('form') do
      click_on 'Entrar'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Olá, #{user.email}")
    expect(page).to have_content('Signed in successfully.')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end

  scenario 'and log out' do
    user = User.create!(email: 'spositogui@example.com', password: 'abc45678')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in "Senha", with: user.password
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end

  scenario 'invalid email' do
    user = User.create!(email: 'spositogui@example.com', password: '123456789')

    visit new_user_session_path
    fill_in 'Email', with: 'spositog@example.com'
    fill_in 'Senha', with: user.password
    within('form') do
      click_on 'Entrar'
    end

    expect(page).to have_content('Invalid Email or password')
  end
end