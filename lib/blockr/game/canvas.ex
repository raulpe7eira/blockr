defmodule Blockr.Game.Canvas do
  @without_color "black"

  def new(contents) do
    """
    <svg width="120" height="220" xmlns="http://www.w3.org/2000/svg">
      #{draw(contents, 10)}
    </svg>
    """
    |> Kino.Image.new(:svg)
  end

  def tetromino(contents) do
    """
    <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
      #{draw(contents, 25)}
    </svg>
    """
    |> Kino.Image.new(:svg)
  end

  defp draw({{row, col}, color}, width) when is_binary(color) do
    x = (col - 1) * width + 10
    y = (row - 1) * width + 10

    ~s'<rect x="#{x}" y="#{y}" width="#{width}" height="#{width}" fill="#{color}" />'
  end

  defp draw({_, _} = point, width) do
    draw({point, @without_color}, width)
  end

  defp draw(points, width) when is_list(points) do
    points
    |> Enum.map(&draw(&1, width))
    |> Enum.join("\n")
  end
end
