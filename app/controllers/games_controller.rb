class GamesController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show, :results]
  before_action :set_game, only: [:show, :edit, :update, :destroy, :results, :user_results]
  before_action :check_game_open!, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.order('start DESC').all.decorate
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = @game.decorate
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def results
    @game = @game.decorate
  end

  def user_results
    @game = @game.decorate
    @user = User.find(params[:user_id]).decorate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :start, :finish)
    end

    def check_game_open!
      unless signed_in_as_admin? || @game.started?
        redirect_to root_path, alert: 'Соревнование еще не началось'
        false
      end
    end
end
