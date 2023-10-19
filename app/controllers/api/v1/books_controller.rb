module Api
  module V1
    class BooksController < ApplicationController
      def index
        # render json: Book.all
        books = Book.all
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id:author.id))
        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private
      def author_params
        params.require(:author).permit(:first_name,:last_name,:age)

      end


      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
# ➜  Nile git:(p8) ✗ curl http://localhost:3000/api/v1/books
#curl --header "Content-Type: application/json" --request POST --data '{"author":"kamran","title":"book1"}'  http://localhost:3000/api/v1/books -v

# curl --header "Content-Type: application/json" --request POST --data '{"author":"kamran","title":"book1"}'  http://localhost:3000/books -v
