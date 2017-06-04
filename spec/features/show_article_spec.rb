require 'rails_helper'

RSpec.feature 'Show Article' do
  before do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    @jane = User.create(email: 'jane@doe.com', password: 'janedoe')
    @jane.confirm

    @article = Article.create(title: 'First Test Article', body: 'Pabst cornhole whatever occupy sriracha kogi, flannel schlitz echo park', user: @john)
  end

  scenario 'To non-signed-in user hide the Edit and Delete buttons' do
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'To non-owner hide the Edit and Delete buttons' do
    login_as(@jane)

    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'A signed in ownner sees both the Edit and Delete buttons' do
    login_as(@john)

    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end