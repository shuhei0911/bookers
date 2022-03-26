class BooksController < ApplicationController
  def index
    @books = Book.all
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
  end

  def create
  	@new_book = Book.new(book_params)

    if @new_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book)
    else
      @books = Book.all.order(created_at: :desc)
      @book = Book.find_by(id: params[:id])
      render "index"
    end

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.title = params[:title]
    @book.body = params[:body]

   if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
   else
      @books = Book.all.order(created_at: :desc)

      render "edit"
   end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end