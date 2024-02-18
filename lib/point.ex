defmodule Point do
  def new(row, col), do: {row, col}

  def move_down({row, col}), do: {row + 1, col}
  def move_left({row, col}), do: {row, col - 1}
  def move_right({row, col}), do: {row, col + 1}
end
