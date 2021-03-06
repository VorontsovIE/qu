class QuestionsController < ApplicationController
  before_action :authenticate!, except: [:show]
  before_action :authenticate_admin!, except: [:show, :answer]
  before_action :set_question, only: [:show, :edit, :update, :destroy, :move_higher, :move_lower, :answer, :user_answers]
  before_action :check_question_open!, only: [:show]
  before_action :check_question_in_play!, only: [:answer]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.decorate
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = @question.decorate
  end

  # GET /questions/new
  def new
    @question = Question.new(game_id: params[:game_id])
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    game = @question.game
    @question.destroy
    respond_to do |format|
      format.html { redirect_to game || games_path, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move_higher
    @question.move_higher
    @question.save!
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def move_lower
    @question.move_lower
    @question.save!
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def answer
    @user_answer = UserAnswer.new(params.require(:user_answer).permit(:answer_text))
    @user_answer.question = @question
    @user_answer.user = current_user

    # @user_answer.answer = @user_answer.find_associated_answer

    if @user_answer.save
      redirect_to @question
    else
      redirect_to @question, alert: @user_answer.errors.full_messages
    end
  end

  def user_answers
    @question = @question.decorate
    @user = User.find(params[:user_id]).decorate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:game_id, :question_text)
    end

    def check_question_open!
      unless signed_in_as_admin? || @question.game.started?
        redirect_to root_path, alert: 'Соревнование еще не началось'
        false
      end
    end

    def check_question_in_play!
      unless signed_in_as_admin? || @question.game.in_play?
        redirect_to root_path, alert: (@question.game.finished? ? 'Соревнование уже закончилось' : 'Соревнование еще не началось')
        false
      end
    end
end
