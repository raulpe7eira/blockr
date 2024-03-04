defmodule Blockr.Game.Group do
  alias Blockr.Game.Color
  alias Blockr.Game.Point

  def move_down(points), do: Enum.map(points, &Point.move_down/1)

  def move_left(points), do: Enum.map(points, &Point.move_left/1)

  def move_right(points), do: Enum.map(points, &Point.move_right/1)

  def move_to(points, location), do: Enum.map(points, &Point.move_to(&1, location))

  def rotate(points, degrees), do: Enum.map(points, &Point.rotate(&1, degrees))

  def paint(points, shape_name), do: Enum.map(points, &Point.paint(&1, Color.for(shape_name)))
end
