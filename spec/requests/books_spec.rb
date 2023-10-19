# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) {FactoryBot.create(:author, first_name: 'George', last_name: 'orweels', age: 48) }
  let(:second_author) {FactoryBot.create(:author, first_name: 'H G', last_name: 'wells', age: 78) }
  describe 'GET /books' do
    before do
    FactoryBot.create(:book, title: '1984', author: first_author)
    FactoryBot.create(:book, title: 'The time machine', author: second_author)
    end
    it 'returns all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to match(
        [
          {
            'id'=> 1,
            'title'=> '1984',
            'author_name' => /George\s+orweels/i,
            'author_age'=> 48
          },
          {
            'id'=> 2,
            'title'=> 'The time machine',
            'author_name' => /H G\s+wells/i,
            'author_age'=> 78
          }
        ]
    )
    end
  end
  describe 'POST /books' do
    it 'creates a new book' do
      expect {
      post '/api/v1/books',params: {
         book:{ title: 'maritans'},
         author:{first_name:'andy',last_name:'weir',age:'48'}}
    }.to change{Book.count}.from(0).to(1)
    expect(response).to have_http_status(:created)
    expect(Author.count).to eq(1)
    expect(response_body).to match(
      {
        'id'=> 1,
        'title'=> 'maritans',
        'author_name' => /andy\s+weir/i,
        'author_age'=> 48
      }
    )
    end
  end
  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }
    it 'deletes a book' do
      expect {
      delete "/api/v1/books/#{book.id}"
    }.to change{Book.count}.from(1).to(0)
    expect(response).to have_http_status(:no_content)
    end
  end
end


