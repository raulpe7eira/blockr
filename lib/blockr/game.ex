defmodule Blockr.Game do
  alias Blockr.Game.Board
  alias Blockr.Game.Tetromino

  def fall(board) do
    crash(board, Tetromino.fall(board.tetro))
  end

  def left(board) do
    attempt(board, Tetromino.left(board.tetro))
  end

  def right(board) do
    attempt(board, Tetromino.right(board.tetro))
  end

  def turn(board) do
    attempt(board, Tetromino.rotate(board.tetro))
  end

  defp crash(board, new_tetro) do
    if collides?(board, new_tetro) do
      board
      |> Board.detach()
      |> Board.put_new_tetro()
    else
      %{board | tetro: new_tetro}
    end
  end

  defp attempt(board, new_tetro) do
    if not collides?(board, new_tetro) do
      %{board | tetro: new_tetro}
    else
      board
    end
  end

  defp collides?(board, new_tetro) do
    extract_point =
      fn {point, _color} -> point end

    tetro_points =
      new_tetro
      |> Tetromino.to_group()
      |> Enum.map(extract_point)
      |> MapSet.new()

    walls_points =
      board.walls
      |> Enum.map(extract_point)
      |> MapSet.new()

    junkyard_points =
      board.junkyard
      |> Enum.map(extract_point)
      |> MapSet.new()

    existing_points =
      MapSet.union(walls_points, junkyard_points)

    tetro_points
    |> MapSet.intersection(existing_points)
    |> MapSet.size() > 0
  end
end
