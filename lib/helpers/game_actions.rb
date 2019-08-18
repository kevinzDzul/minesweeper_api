class Helpers::GameActions

    def initialize(params)
        @id = params[:id]
        @row = params[:row]
        @column = params[:column]
        @open_cells = 0
    end

    def validate
        @game = Game.find(@id)
        open_cell(@row, @column)
        @game.cell_open += @open_cells
        @game.status =  @game.cell_open >= ((@game.row * @game.column) - @game.mines) ? 'winner' : 'started'
        @game if @game.save()
    end

    def validate_is_mine 
        is_mine = @game.board[@row]["grid"][@column]["is_mine"]
        unless !is_mine
            @game.status = 'lost'
            @game.board.map{|board| board["grid"].map{|grid|
                unless !grid["is_mine"] 
                    grid["visible"] =  true
                end
                }
            }
        end
    end

    def open_cell row, column
        cell = @game.board[row]["grid"][column]
        unless cell["visible"]
            @open_cells += 1
            cell["visible"] = true
            validate_is_mine()
            unless cell["near_mine"] == 0
                min_max_row = [9, row+1,0, row-1].minmax
                min_max_column = [9, column+1,0, column-1].minmax
                for x in min_max_row[1]..min_max_row[0]
                    for y in min_max_column[1]..min_max_column[0] 
                        unless @game.board[x]["grid"][y]["is_mine"]
                            open_cell(x, y)
                        end
                    end
                end
            end
        end
    end


end