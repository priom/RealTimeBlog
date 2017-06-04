require 'rails_helper'

RSpec.feature 'Listing Articles' do
  before do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    @article1 = Article.create(title: 'First Test Article', body: 'Pabst cornhole whatever occupy sriracha kogi, flannel schlitz echo park', user: @john)

    @article2 = Article.create(title: 'Second Test Article', body: 'Cliche portland meggings, meditation distillery farm-to-table lumbersexual kitsch raclette', user: @john)
  end

  scenario 'With articles created and user signed in' do
    login_as(@john)

    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
  end

  scenario 'With articles created and user not signed in' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end

  scenario 'A user lists all articles' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario 'A user has no articles' do
    Article.delete_all

    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)

    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)

    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within('h1') do
      expect(page).to have_content('No articles created yet!')
    end
  end
end