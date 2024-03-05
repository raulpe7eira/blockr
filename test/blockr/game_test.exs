defmodule Blockr.GameTest do
  use ExUnit.Case

  alias Blockr.Game
  alias Blockr.Game.Board
  alias Blockr.Game.Tetromino

  setup do
    %{board: Board.new(tetro: %Tetromino{name: :i, location: {0, 3}, rotation: 0, color: "blue"})}
  end

  describe "fall/1" do
    test "when given a valid board, fall tetro", ctx do
      assert %Board{tetro: tetro} = Game.fall(ctx.board)
      assert %Tetromino{location: {1, 3}} = tetro
    end

    test "when given a valid board and fall has collision, fall new tetro", ctx do
      assert board = Enum.reduce(1..16, ctx.board, fn _, board -> Game.fall(board) end)

      assert %Board{tetro: new_tetro, junkyard: new_junkyard} = Game.fall(board)
      assert board.tetro != new_tetro
      assert board.junkyard != new_junkyard

      assert new_junkyard == [
               {{17, 5}, "blue"},
               {{18, 5}, "blue"},
               {{19, 5}, "blue"},
               {{20, 5}, "blue"}
             ]
    end
  end

  describe "left/1" do
    test "when given a valid board, move tetro to left", ctx do
      assert %Board{tetro: tetro} = Game.left(ctx.board)
      assert %Tetromino{location: {0, 2}} = tetro
    end

    test "when given a valid board and move has collision, not move", ctx do
      assert board = Enum.reduce(1..10, ctx.board, fn _, board -> Game.left(board) end)

      assert %Board{tetro: new_tetro} = Game.left(board)
      assert board.tetro == new_tetro
    end
  end

  describe "right/1" do
    test "when given a valid board, move tetro to right", ctx do
      assert %Board{tetro: tetro} = Game.right(ctx.board)
      assert %Tetromino{location: {0, 4}} = tetro
    end

    test "when given a valid board and move has collision, not move", ctx do
      assert board = Enum.reduce(1..10, ctx.board, fn _, board -> Game.right(board) end)

      assert %Board{tetro: new_tetro} = Game.right(board)
      assert board.tetro == new_tetro
    end
  end

  describe "turn/1" do
    test "when given a valid board, rotate tetro", ctx do
      assert %Board{tetro: tetro} = Game.turn(ctx.board)
      assert %Tetromino{rotation: 90} = tetro
    end

    test "when given a valid board and rotate has collision, not move", ctx do
      assert board =
               Enum.reduce(1..100, ctx.board, fn _, board ->
                 board
                 |> Game.turn()
                 |> Game.right()
               end)

      assert %Board{tetro: new_tetro} = Game.turn(board)
      assert board.tetro == new_tetro
    end
  end
end
