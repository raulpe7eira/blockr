defmodule Blockr.Game.Board do
  alias Blockr.Game.Point
  alias Blockr.Game.Tetromino

  defstruct score: 0, tetro: nil, walls: [], junkyard: []

  @walls_color "black"

  def new(opts \\ []) when is_list(opts) do
    opts
    |> __struct__()
    |> init_tetro()
    |> add_walls()
  end

  defp init_tetro(%{tetro: nil} = board), do: put_new_tetro(board)
  defp init_tetro(board), do: board

  defp add_walls(board) do
    walls =
      for row <- 0..21, col <- 0..11, row in [0, 21] or col in [0, 11] do
        {{row, col}, @walls_color}
      end

    %{board | walls: walls}
  end

  def detach(board) do
    %{board | junkyard: board.junkyard ++ Tetromino.to_group(board.tetro)}
    |> add_score()
    |> eat_completed_rows()
  end

  defp add_score(board) do
    number_of_rows = count_completed_rows(board)

    score =
      cond do
        number_of_rows == 0 -> 0
        true -> :math.pow(2, number_of_rows) |> round() |> Kernel.*(50)
      end

    %{board | score: score}
  end

  defp count_completed_rows(board) do
    extract_point =
      fn {point, _color} -> point end

    board.junkyard
    |> Enum.map(extract_point)
    |> Enum.group_by(fn {r, _} -> r end)
    |> Map.values()
    |> Enum.count(fn list -> length(list) == 10 end)
  end

  def eat_completed_rows(board) do
    rows = Enum.group_by(board.junkyard, fn {{row, _col}, _color} -> row end)

    completed =
      rows
      |> Enum.filter(fn {_row, list} -> length(list) == 10 end)
      |> Map.new()
      |> Map.keys()

    junkyard =
      Enum.reduce(completed, rows, &eat_row/2)
      |> Map.values()
      |> List.flatten()

    %{board | junkyard: junkyard}
  end

  defp eat_row(row_number, rows) do
    rows
    |> Map.delete(row_number)
    |> Enum.map(fn
      {row, list} when row_number > row -> {row + 1, move_all_down(list)}
      row_with_list -> row_with_list
    end)
    |> Map.new()
  end

  defp move_all_down(points) do
    Enum.map(points, fn {point, color} -> {Point.move_down(point), color} end)
  end

  def put_new_tetro(board) do
    random_name =
      [:i, :l, :j, :o, :s, :t, :z]
      |> Enum.random()

    %{board | tetro: Tetromino.new(name: random_name, location: {0, 3})}
  end

  def show(board) do
    [Tetromino.to_group(board.tetro), board.walls, board.junkyard]
  end
end
