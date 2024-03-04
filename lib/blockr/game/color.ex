defmodule Blockr.Game.Color do
  def for(shape_name) do
    case shape_name do
      :i -> "blue"
      :l -> "brown"
      :j -> "orange"
      :o -> "purple"
      :s -> "yellow"
      :t -> "green"
      :z -> "red"
    end
  end
end
