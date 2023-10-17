module Api
  module V1
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

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private
      def book_params
        params.require(:book).permit(:author, :title)
      end
    end
  end
end
# ➜  Nile git:(p8) ✗ curl http://localhost:3000/api/v1/books
#curl --header "Content-Type: application/json" --request POST --data '{"author":"kamran","title":"book1"}'  http://localhost:3000/api/v1/books -v

# curl --header "Content-Type: application/json" --request POST --data '{"author":"kamran","title":"book1"}'  http://localhost:3000/books -v
