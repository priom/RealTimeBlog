require 'rails_helper'

RSpec.feature 'Deleting an Article' do
  before do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm
    login_as(@john)

    @article = Article.create(title: 'Title One', body: 'Body of test article one', user: @john)
  end

  scenario 'A user deletes an article' do
    visit '/'

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(page.current_path).to eq(articles_path)
  end
end