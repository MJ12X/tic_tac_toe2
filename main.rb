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

  @@PLAYER_TURNS = {
    "X" => :playerone,
    "O" => :playertwo
}

  def initialize
    @grid = Array.new(3) {Array.new(3, "")}
    @turns = 0
  end

  def reset
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
    win
  end
  
  def win
    @@WIN_CONDITION.each do |possible_win|
      first_symbol = grid[possible_win[0][0]][possible_win[0][1]]
        next if first_symbol.nil?
        if possible_win.all? {|row,col| grid[row][col] == first_symbol}
        return @@PLAYER_TURNS[first_symbol]
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
    @playerOne = Player.new('X', '1')
    @playerTwo = Player.new('O', '2')
    @board     = Board.new
  end

  def player_input
    current_player_symbol = @board.turns.even? ? @playerOne.symbol : @playerTwo.symbol
    puts "where would you like to put your piece player #{current_player_symbol}? '(x,y)'"
    loop do
      input = gets.chomp
      begin
        return @board.place_symbol(input[1].to_i, input[4].to_i, current_player_symbol)
      rescue RuntimeError => e
      puts "it seems you've inputted invalid coordinates #{e.message}, please pick valid coordinates '(x,y)'"
    end
  end
end

  def start
  puts
    while @board.turns < 9
      the_winner = player_input
      @board.grid_display
      puts "Player one wins" if the_winner == :playerone
      puts "Player two wins" if the_winner == :playertwo
      @board.reset if the_winner
    end
    puts "It's a draw!"
    @board.reset
  end
end


test = Game.new
loop do 
  test.start
end
      