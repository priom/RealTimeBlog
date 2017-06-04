require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @john = User.create(email: 'john@doe.com', password: 'johndoe')
    @john.confirm

    @jane = User.create(email: 'jane@doe.com', password: 'janedoe')
    @jane.confirm

    @article = Article.create!(title: 'Title One', body: 'Body of test article one', user: @john)
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it 'handles existing article' do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it 'handles non-existing article' do
        expect(response.status).to eq 302
        flash_message = 'The article you are looking for could not be found'
        expect(flash[:warning]).to eq flash_message
      end
    end
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed-in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the signin page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed-in user who is not owner' do
      before do
        login_as(@jane)
        get "/articles/#{@article.id}/edit"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article'
        expect(flash[:danger]).to eq flash_message
      end
    end

    context 'with signed-in user as owner successful edit' do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end

      it 'successfully edits article' do
        expect(response.status).to eq 200
      end
    end
  end
end