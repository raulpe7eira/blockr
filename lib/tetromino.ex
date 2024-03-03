defmodule Tetromino do
  @doc """
  t: ***
      *

  l: *
     *
     **

  j:  *
      *
     **

  i: *
     *
     *
     *

  o: **
     **

  s:  **
     **

  z: **
      **
  """

  defstruct name: :i, location: {1, 1}, rotation: 0, color: :green

  def new(name \\ :i) do
    %__MODULE__{name: name}
  end

  def fall(tetro) do
    %{tetro | location: Point.move_down(tetro.location)}
  end

  def left(tetro) do
    %{tetro | location: Point.move_left(tetro.location)}
  end

  def right(tetro) do
    %{tetro | location: Point.move_right(tetro.location)}
  end

  def rotate(tetro) do
    %{tetro | rotation: rem(tetro.rotation + 90, 360)}
  end

  def to_group(tetro) do
    tetro.name
    |> case do
      :i -> [{1, 2}, {2, 2}, {3, 2}, {4, 2}]
      :l -> [{1, 2}, {2, 2}, {3, 2}, {3, 3}]
      :j -> [{1, 3}, {2, 3}, {3, 2}, {3, 3}]
      :o -> [{1, 2}, {1, 3}, {2, 2}, {2, 3}]
      :s -> [{2, 3}, {2, 4}, {3, 2}, {3, 3}]
      :t -> [{1, 2}, {2, 2}, {3, 2}, {2, 3}]
      :z -> [{2, 2}, {2, 3}, {3, 3}, {3, 4}]
    end
    |> Group.rotate(tetro.rotation)
  end
end
