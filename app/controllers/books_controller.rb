class BooksController < ApplicationController
  before_action :require_admin, except: %i[ show ]
  before_action :set_book, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:search_cover, :apply_cover]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "O livro foi cadastrado com sucesso!" }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, notice: "Book was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /books/search_cover
  def search_cover
    service = GoogleBooksCoverSearch.new(
      title: params[:title],
      author: params[:author],
      publisher: params[:publisher]
    )

    cover_url = service.call

    render json: { cover_url: cover_url }
  end

  # GET /books/proxy_image - Baixa imagem e retorna como base64 para evitar CORS
  def proxy_image
    require 'open-uri'
    
    image_data = URI.open(params[:url]).read
    base64_image = Base64.strict_encode64(image_data)
    
    render json: { 
      data: "data:image/jpeg;base64,#{base64_image}",
      filename: "cover.jpg"
    }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # POST /books/apply_cover
  def apply_cover
    book = Book.find(params[:id])
    file = URI.open(params[:cover_url])

    book.cover.attach(
      io: file,
      filename: "cover.jpg",
      content_type: "image/jpeg"
    )

    render json: { success: true, message: "Capa aplicada com sucesso!" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.expect(book: [ :cover, :title, :author, :isbn, :publisher ])
    end
end
