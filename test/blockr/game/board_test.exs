defmodule Blockr.Game.BoardTest do
  use ExUnit.Case

  alias Blockr.Game.Color
  alias Blockr.Game.Tetromino
  alias Blockr.Game.Board

  @walls [
    {{0, 0}, "black"},
    {{0, 1}, "black"},
    {{0, 2}, "black"},
    {{0, 3}, "black"},
    {{0, 4}, "black"},
    {{0, 5}, "black"},
    {{0, 6}, "black"},
    {{0, 7}, "black"},
    {{0, 8}, "black"},
    {{0, 9}, "black"},
    {{0, 10}, "black"},
    {{0, 11}, "black"},
    {{1, 0}, "black"},
    {{1, 11}, "black"},
    {{2, 0}, "black"},
    {{2, 11}, "black"},
    {{3, 0}, "black"},
    {{3, 11}, "black"},
    {{4, 0}, "black"},
    {{4, 11}, "black"},
    {{5, 0}, "black"},
    {{5, 11}, "black"},
    {{6, 0}, "black"},
    {{6, 11}, "black"},
    {{7, 0}, "black"},
    {{7, 11}, "black"},
    {{8, 0}, "black"},
    {{8, 11}, "black"},
    {{9, 0}, "black"},
    {{9, 11}, "black"},
    {{10, 0}, "black"},
    {{10, 11}, "black"},
    {{11, 0}, "black"},
    {{11, 11}, "black"},
    {{12, 0}, "black"},
    {{12, 11}, "black"},
    {{13, 0}, "black"},
    {{13, 11}, "black"},
    {{14, 0}, "black"},
    {{14, 11}, "black"},
    {{15, 0}, "black"},
    {{15, 11}, "black"},
    {{16, 0}, "black"},
    {{16, 11}, "black"},
    {{17, 0}, "black"},
    {{17, 11}, "black"},
    {{18, 0}, "black"},
    {{18, 11}, "black"},
    {{19, 0}, "black"},
    {{19, 11}, "black"},
    {{20, 0}, "black"},
    {{20, 11}, "black"},
    {{21, 0}, "black"},
    {{21, 1}, "black"},
    {{21, 2}, "black"},
    {{21, 3}, "black"},
    {{21, 4}, "black"},
    {{21, 5}, "black"},
    {{21, 6}, "black"},
    {{21, 7}, "black"},
    {{21, 8}, "black"},
    {{21, 9}, "black"},
    {{21, 10}, "black"},
    {{21, 11}, "black"}
  ]

  setup do
    %{
      board: %Board{
        score: 0,
        tetro: %Tetromino{name: :i, location: {0, 3}, rotation: 0, color: "blue"},
        walls: @walls,
        junkyard: []
      }
    }
  end

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

  describe "count_completed_rows/1" do
    test "when given a valid board, count the completed rows", ctx do
      junkyard = for r <- 17..20, c <- 1..10, do: {{r, c}, "purple"}

      assert Board.count_completed_rows(%{ctx.board | junkyard: junkyard}) == 4
    end
  end

  describe "detach/1" do
    test "when given a valid board, detach a crashed tetro", ctx do
      assert Board.detach(ctx.board) == %Board{
               score: 0,
               tetro: %Tetromino{
                 name: :i,
                 location: {0, 3},
                 rotation: 0,
                 color: "blue"
               },
               walls: @walls,
               junkyard: [
                 {{1, 5}, "blue"},
                 {{2, 5}, "blue"},
                 {{3, 5}, "blue"},
                 {{4, 5}, "blue"}
               ]
             }
    end
  end

  describe "put_new_tetro/1" do
    test "when given a valid board, put a new tetro", ctx do
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
             } = Board.put_new_tetro(ctx.board)

      assert name_shape in [:i, :l, :j, :o, :s, :t, :z]
      assert color_shape == Color.for(name_shape)
    end
  end

  describe "show/1" do
    test "when given a valid board, convert to groups", ctx do
      assert Board.show(ctx.board) == [
               [
                 {{1, 5}, "blue"},
                 {{2, 5}, "blue"},
                 {{3, 5}, "blue"},
                 {{4, 5}, "blue"}
               ],
               @walls,
               ctx.board.junkyard
             ]
    end
  end
end
