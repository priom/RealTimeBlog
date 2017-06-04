require 'rails_helper'

RSpec.feature 'Show Article' do
  before do
    john = User.create(email: 'john@doe.com', password: 'johndoe')
    john.confirm
    login_as(john)

    @article = Article.create(title: 'First Test Article', body: 'Pabst cornhole whatever occupy sriracha kogi, flannel schlitz echo park', user: john)
  end

  scenario 'A user shows an article' do
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    expect(current_path).to eq(article_path(@article))
  end
end