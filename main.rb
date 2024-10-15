class Board
  attr_accessor :grid, :turns
  def initialize
    @grid = Array.new(3) {Array.new(3, "")}
    @turns = 0
  end