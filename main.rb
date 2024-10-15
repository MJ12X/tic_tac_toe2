class Board
  attr_accessor :grid, :turns

  @@WIN_CONDITION = [
    [[0, 0], [0, 1], [0, 2]], 
    [[1, 0], [1, 1], [1, 2]],
    [[2, 0], [2, 1], [2, 2]],
    [[0, 0], [1, 0], [2, 0]],
    [[0, 1], [1, 1], [2, 1]],
    [[0, 2], [1, 2], [2, 2]],
    [[0, 0], [1, 1], [2, 2]],
    [[0, 2], [1, 1], [2, 0]]
  ]

  def initialize
    @grid = Array.new(3) {Array.new(3, "")}
    @turns = 0
  end

  def grid_display
    grid.each_with_index do |row,index|
    puts row.join(" | ")
    puts "-------" unless index == grid.length - 1
    end
  end

  def place_symbol(row, col, symb)
    if !row.between?(0, 2) || !col.between?(0, 2)
      puts "Invalid position"
      return
    end

    if grid[row][col] != ""
      puts "Position taken"
      return
    end
    grid[row][col] = symb
    @turns += 1 
  end
end

class Player
  attr_accessor :index, :symbol
  
  def initialize(symbol,index)
    @symbol = symbol
    @index  = index
  end
end