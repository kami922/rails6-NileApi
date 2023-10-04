class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end
  private
  def book_params
    params.require(:book).permit(:author, :title)
  end
end
 # curl --header "Content-Type: application/json" --request POST --data '{"author":"kamran","title":"book1"}'  http://localhost:3000/books -v
#
