# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  it 'returns all books' do
    FactoryBot.create(:book,title:"1984",author:"george orwells")
    FactoryBot.create(:book,title:"The time machine",author:"H.G wells")
    get '/api/v1/books'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
