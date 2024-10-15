class Board
  attr_accessor :grid, :turns
  def initialize
    @grid = Array.new(3) {Array.new(3, "")}
    @turns = 0
  end

  def grid_display
    grid.each_with_index do |row,index|
    puts row.join("|")
    puts "-------" unless index == grid.length - 1
    end
  end