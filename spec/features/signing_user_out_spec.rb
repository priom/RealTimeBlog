require 'rails_helper'

RSpec.feature 'Signin out logged-in user' do
  before do
    @john = User.create!(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    visit '/'

    click_link 'Signin'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Sign in'
  end

  scenario do
    visit '/'

    click_link 'Signout'
    expect(page).to have_content('Signed out successfully.')
    expect(page).not_to have_content('Signout')
  end
end