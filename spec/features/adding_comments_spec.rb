require 'rails_helper'

RSpec.feature "Adding comments to articles" do
  before  do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    @jane = User.create(email: 'jane@doe.com', password: 'janedoe')
    @jane.confirm

    @article = Article.create!(title: 'Title One', body: 'Body of test article one', user: @john)
  end

  scenario 'permits a signed in user to write comments' do
    login_as(@jane)

    visit '/'

    click_link @article.title
    fill_in 'New Comment', with: 'An awesome article'
    click_button 'Add Comment'

    expect(page).to have_content('Comment has been created')
    expect(page).to have_content('An awesome article')
    expect(current_path).to eq(article_path(@article.id))
  end
end