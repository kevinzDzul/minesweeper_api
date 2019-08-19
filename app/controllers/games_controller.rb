include Swagger::Blocks
class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  swagger_path '/games/{id}' do

    # GET /games/:id
    operation :get do
      key :description, 'Find a user by ID'
      key :operationId, :show

      # definición del parámetro id incluido en el path
      parameter :id do
        key :in, :path
        key :description, 'Game ID'
        key :required, true
        key :type, :integer
        key :format, :int64 
      end

      # definición del success response
      response 200 do
        key :description, 'Game'
        schema do
          key :required, [:id, :name]
          property :id do
            key :type, :integer
            key :format, :int64
          end
          property :name do
            key :type, :string
          end
        end
      end
    end
  end






  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  def show
    render json: @game
  end

  # POST /games
  def create
    @game = ::Helpers::GameGenerator.new(params_to_create_game).generate
    if @game
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /game/pause/1
  def pause
    @game = Game.find(params[:game_id])
    unless @game.status == 'paused'
      @game.update_attributes!(status: 'paused')
    end
    render json: @game, root: 'game'
  end

  # PATCH/PUT /game/resume/1
  def resume
    @game = Game.find(params[:game_id])
    unless @game.status == 'started'
      game.update_attributes!(status: 'started')   
    end
    render json: @game, root: 'game'
  end

  # PATCH/POST /game/flag/1
  def flag
    @game = Game.find(params[:game_id])
    board = @game.board[params[:row]]["grid"][params[:column]]
    board["is_flag"] = !board["is_flag"]
    @game.save()
    render json: @game, root: 'game'
  end

  # PATCH/POST /game/validate/1
  def validate
    @params = {
      id: params[:game_id],
      row: params[:row],
      column: params[:column]
    }
    @game = ::Helpers::GameActions.new(@params).validate
    if @game
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:name, :row, :column, :mines, :status)
    end


    def params_to_create_game
      params.require(:game).permit(:name, :row, :column, :mines)
    end

    

end
