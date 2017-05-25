require 'rails_helper'

RSpec.feature 'Users signin' do
  before do
    @john = User.create!(email: 'john@doe.com', password: 'johndoe')
    @john.confirm
  end

  scenario 'with valid credentials' do
    visit '/'

    click_link 'Signin'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_link('Signin')
    expect(page).not_to have_link('Signup')
  end
end