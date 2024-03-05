defmodule Blockr.Game.Board do
  alias Blockr.Game.Tetromino

  defstruct score: 0, tetro: nil, walls: [], junkyard: []

  def new(opts \\ []) when is_list(opts) do
    opts
    |> __struct__()
    |> init_tetro()
    |> add_walls()
  end

  defp init_tetro(board) do
    random_name =
      [:i, :l, :j, :o, :s, :t, :z]
      |> Enum.random()

    %{board | tetro: Tetromino.new(name: random_name, location: {0, 3})}
  end

  defp add_walls(board) do
    walls =
      for row <- 0..21, col <- 0..11, row in [0, 21] or col in [0, 11] do
        {row, col}
      end

    %{board | walls: walls}
  end
end
