defmodule Group do
  def move_down(points), do: Enum.map(points, &Point.move_down/1)

  def move_left(points), do: Enum.map(points, &Point.move_left/1)

  def move_right(points), do: Enum.map(points, &Point.move_right/1)

  def move_to(points, location), do: Enum.map(points, &Point.move_to(&1, location))

  def rotate(points, degrees), do: Enum.map(points, &Point.rotate(&1, degrees))
end
