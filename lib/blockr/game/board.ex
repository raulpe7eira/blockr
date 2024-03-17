defmodule Blockr.Game.Board do
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
    add_score(%{board | junkyard: board.junkyard ++ Tetromino.to_group(board.tetro)})
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
end
