defmodule Point do
  def new(row, col), do: {row, col}

  def move_down({row, col}), do: {row + 1, col}

  def move_left({row, col}), do: {row, col - 1}

  def move_right({row, col}), do: {row, col + 1}

  def rotate(point, 0), do: point

  def rotate(point, 90) do
    point
    |> swap()
    |> flip_left_right()
  end

  def rotate(point, 180) do
    point
    |> flip_top_bottom()
    |> flip_left_right()
  end

  def rotate(point, 270) do
    point
    |> swap()
    |> flip_top_bottom()
  end

  defp swap({row, col}), do: {col, row}

  defp flip_left_right({row, col}), do: {row, 5 - col}

  defp flip_top_bottom({row, col}), do: {5 - row, col}
end
