defmodule Blockr.Game.BoardTest do
  use ExUnit.Case

  alias Blockr.Game.Color
  alias Blockr.Game.Tetromino
  alias Blockr.Game.Board

  @walls [
    {0, 0},
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4},
    {0, 5},
    {0, 6},
    {0, 7},
    {0, 8},
    {0, 9},
    {0, 10},
    {0, 11},
    {1, 0},
    {1, 11},
    {2, 0},
    {2, 11},
    {3, 0},
    {3, 11},
    {4, 0},
    {4, 11},
    {5, 0},
    {5, 11},
    {6, 0},
    {6, 11},
    {7, 0},
    {7, 11},
    {8, 0},
    {8, 11},
    {9, 0},
    {9, 11},
    {10, 0},
    {10, 11},
    {11, 0},
    {11, 11},
    {12, 0},
    {12, 11},
    {13, 0},
    {13, 11},
    {14, 0},
    {14, 11},
    {15, 0},
    {15, 11},
    {16, 0},
    {16, 11},
    {17, 0},
    {17, 11},
    {18, 0},
    {18, 11},
    {19, 0},
    {19, 11},
    {20, 0},
    {20, 11},
    {21, 0},
    {21, 1},
    {21, 2},
    {21, 3},
    {21, 4},
    {21, 5},
    {21, 6},
    {21, 7},
    {21, 8},
    {21, 9},
    {21, 10},
    {21, 11}
  ]

  describe "new/0" do
    test "when call new, create a new board" do
      assert %Board{
               score: 0,
               tetro: %Tetromino{
                 name: name_shape,
                 location: {0, 3},
                 rotation: 0,
                 color: color_shape
               },
               walls: @walls,
               junkyard: []
             } = Board.new()

      assert name_shape in [:i, :l, :j, :o, :s, :t, :z]
      assert color_shape == Color.for(name_shape)
    end
  end

  describe "new/1" do
    test "when given a valid opts, create a new board" do
      assert %Board{
               score: 10,
               tetro: %Tetromino{
                 name: name_shape,
                 location: {0, 3},
                 rotation: 0,
                 color: color_shape
               },
               walls: @walls,
               junkyard: []
             } = Board.new(score: 10)

      assert name_shape in [:i, :l, :j, :o, :s, :t, :z]
      assert color_shape == Color.for(name_shape)
    end
  end
end
