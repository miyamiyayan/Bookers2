class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
    flash[:notice] = "successfully"
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:notice] = "Book was successfully destroyed."
  end

  def edit
    @book = Book.find(params[:id])
      if current_user == @book.user
        render :edit
      else
        redirect_to books_path
      end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
    flash[:notice] = "successfully"
  end



private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
