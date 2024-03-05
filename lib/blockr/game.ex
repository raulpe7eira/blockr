defmodule Blockr.Game do
  alias Blockr.Game.Tetromino

  def left(board) do
    %{board | tetro: attempt(board, Tetromino.left(board.tetro))}
  end

  def right(board) do
    %{board | tetro: attempt(board, Tetromino.right(board.tetro))}
  end

  def turn(board) do
    %{board | tetro: attempt(board, Tetromino.rotate(board.tetro))}
  end

  defp attempt(board, new_tetro) do
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

    no_collision? =
      tetro_points
      |> MapSet.intersection(walls_points)
      |> MapSet.size() == 0

    if no_collision? do
      new_tetro
    else
      board.tetro
    end
  end
end
