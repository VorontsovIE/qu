class UserAnswersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user_answer, only: [:show, :edit, :update, :destroy]
  # GET /user_answers
  # GET /user_answers.json
  def index
    if params[:game_id]
      @user_answers = Game.find(params[:game_id]).user_answers.order('created_at DESC')
      # UserAnswer.where(game: params[:game_id]).order('created_at DESC').all.decorate
    else
      @user_answers = UserAnswer.order('created_at DESC')
    end

    if params[:limit]
      unless params[:limit].to_s.downcase == 'all'
        @user_answers = @user_answers.limit(params[:limit].to_i)
      end
    else
      @user_answers = @user_answers.limit(30)  # default limit
    end
    @user_answers = @user_answers.decorate
  end

  # GET /user_answers/1
  # GET /user_answers/1.json
  def show
    @user_answer = @user_answer.decorate
  end

  # GET /user_answers/new
  def new
    @user_answer = UserAnswer.new
  end

  # GET /user_answers/1/edit
  def edit
  end

  # POST /user_answers
  # POST /user_answers.json
  def create
    @user_answer = UserAnswer.new(user_answer_params)

    respond_to do |format|
      if @user_answer.save
        format.html { redirect_to @user_answer, notice: 'User answer was successfully created.' }
        format.json { render :show, status: :created, location: @user_answer }
      else
        format.html { render :new }
        format.json { render json: @user_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_answers/1
  # PATCH/PUT /user_answers/1.json
  def update
    respond_to do |format|
      if @user_answer.update(user_answer_params)
        format.html { redirect_to @user_answer, notice: 'User answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_answer }
      else
        format.html { render :edit }
        format.json { render json: @user_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_answers/1
  # DELETE /user_answers/1.json
  def destroy
    @user_answer.destroy
    respond_to do |format|
      format.html { redirect_to user_answers_url, notice: 'User answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_answer
      @user_answer = UserAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_answer_params
      params[:user_answer].permit(:question_id, :answer_text, :user_id)
    end
end
