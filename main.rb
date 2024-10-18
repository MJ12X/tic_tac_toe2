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

  @@PLAYER_TURNS = [
    "one" => :playerone,
    "two" => :playertwo
  ]

  def initialize
    @grid = Array.new(3) {Array.new(3, "")}
    @turns = 0
  end

  def reset
    @grid = Array.new(3) {Array.new (3, "")}
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
    win
  end

  def win
    @@WIN_CONDITION.each do |possible_win|
      potential_win = possible_win.map {|row,col| grid[row][col]}
        if potential_win[0] && potential_win.all? {|sym| sym = potential_win[0]}
        return @@PLAYER_TURNS[potential_win[0]]
      end
    end
    false
  end
end

class Player
  attr_accessor :index, :symbol
  
  def initialize(symbol,index)
    @symbol = symbol
    @index  = index
  end
end

class Game
  
  def initialize
    @playerOne = Player.new('1', 'X')
    @playerTwo = Player.new('2', 'X')
    @board     = Board.new
  end

  def player_input
  current_player = if self.board.moves_made_even "one"
  else "two"
    puts "where would you like to put your piece player #{current_player}? '(x,y)'"
    loop do
      input = gets.chomp
      begin
        self.board.place_symbol(input[1].to_i, input[4].to_i, current_player)
      rescue RuntimeError => e
        puts "it seems you've inputted invalid coordinates #{e.message}, please pick valid coordinates '(x,y)'"
      end
    end
  end
end
      


end
      