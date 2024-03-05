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
    %{board | junkyard: board.junkyard ++ Tetromino.to_group(board.tetro)}
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
