defmodule Blockr.GameTest do
  use ExUnit.Case

  alias Blockr.Game
  alias Blockr.Game.Board
  alias Blockr.Game.Tetromino

  setup do
    %{board: Board.new()}
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
