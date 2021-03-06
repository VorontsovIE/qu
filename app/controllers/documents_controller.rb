class DocumentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @documents = Document.all.decorate
    respond_with(@documents)
  end

  def show
    @document = @document.decorate
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.save
    respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    respond_with(@document)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:file, :filename, :question_id)
    end
end
