require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    @jane = User.create(email: 'jane@doe.com', password: 'janedoe')
    @jane.confirm

    @article = Article.create!(title: 'Title One', body: 'Body of test article one', user: @john)
  end

  describe 'POST /articles/:id/comments/' do
    context 'with a non-signed-in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: 'Awesome article!'}}
      end

      it 'redirect user to the signin page' do
        flash_message = 'Please sign in or sign up first'
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:warning]).to eq flash_message
      end
    end

    context 'with a signed in user' do
      before do
        login_as(@jane)

        post "/articles/#{@article.id}/comments", params: {comment: {body: 'Awesome article!'}}
      end

      it 'create the comment successfully' do
        flash_message = 'Comment has been added'
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:success]).to eq flash_message
      end
    end
  end
end
