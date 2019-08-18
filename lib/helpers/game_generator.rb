class Helpers::GameGenerator

    def initialize(params)
      @name_game = params[:name]
      @num_rows = params[:row]
      @num_columns = params[:column]
      @mines_in_board = params[:mines]
      @my_board = generate_board(@num_rows, @num_columns, @mines_in_board)
      @game = Game.new
      @game.name = @name_game
      @game.row = @num_rows
      @game.cell_open = 0
      @game.column = @num_columns
      @game.mines = @mines_in_board
      @game.board = @my_board
    end

    def generate
      @game.save
      @game
    end

    def generate_board num_rows, num_columns, mines_in_board
      board = [];
      (0...num_rows).flat_map do |x|
        row = {
          row:x,
          grid: get_grid(num_columns)
        }
        board.push(row)
      end
      get_mines(mines_in_board,num_rows,num_columns,board)
    end
  
  
    def get_grid num_columns
      grid = []
      (0...num_columns).map do |y|
        item_grid = {
          column:y,
          is_mine:false,
          visible:false,
          is_flag:false,
          near_mine:0
        }
        grid.push(item_grid);
      end
      grid
    end
  
    def get_mines num_mines, num_rows, num_columns, board
      num_mines.times do        
        begin
          row =rand(0..num_rows - 1)
          column = rand(0..num_rows - 1)
        end while board[row][:grid][column][:is_mine]
        board[row][:grid][column][:is_mine]  = true
        board = find_mines_adjacent(row, column, board)
      end
      board
    end
  
    def find_mines_adjacent row, column , board
      min_to_row = [9, row+1].min
      max_to_row = [0, row-1].max
      min_to_column = [9, column+1].min
      max_to_column = [0, column-1].max
      for x in max_to_row..min_to_row
        for y in max_to_column..min_to_column
          grid = board[x][:grid][y]
          unless grid[:is_mine]
            grid[:near_mine] += 1
          end
        end
      end
      board 
    end
end