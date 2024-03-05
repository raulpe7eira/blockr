defmodule Blockr.Game.TetrominoTest do
  use ExUnit.Case

  alias Blockr.Game.Tetromino

  setup(ctx) do
    name = Map.get(ctx, :tetro_name, :i)

    %{tetro: %Tetromino{name: name, location: {1, 1}, rotation: 0, color: "blue"}}
  end

  describe "new/0" do
    test "when call new, create a new tetromino" do
      assert Tetromino.new() == %Tetromino{
               name: :i,
               location: {0, 0},
               rotation: 0,
               color: "blue"
             }
    end
  end

  describe "new/1" do
    test "when given a valid opts, create a new tetromino" do
      assert Tetromino.new(name: :z) == %Tetromino{
               name: :z,
               location: {0, 0},
               rotation: 0,
               color: "red"
             }
    end
  end

  describe "fall/1" do
    test "when given a valid tetro, move tetro to fall", ctx do
      assert Tetromino.fall(ctx.tetro) == %Tetromino{
               name: :i,
               location: {2, 1},
               rotation: 0,
               color: "blue"
             }
    end
  end

  describe "left/1" do
    test "when given a valid tetro, move tetro to left", ctx do
      assert Tetromino.left(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 0},
               rotation: 0,
               color: "blue"
             }
    end
  end

  describe "right/1" do
    test "when given a valid tetro, move tetro to right", ctx do
      assert Tetromino.right(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 2},
               rotation: 0,
               color: "blue"
             }
    end
  end

  describe "rotate/1" do
    test "when given a valid tetro, rotate tetro to 90 degrees to right", ctx do
      assert Tetromino.rotate(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 1},
               rotation: 90,
               color: "blue"
             }

      assert Enum.reduce(1..2, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 180,
                 color: "blue"
               }

      assert Enum.reduce(1..3, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 270,
                 color: "blue"
               }

      assert Enum.reduce(1..4, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 0,
                 color: "blue"
               }
    end
  end

  describe "to_group/1" do
    test "when given a valid :i tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{2, 3}, "blue"},
               {{3, 3}, "blue"},
               {{4, 3}, "blue"},
               {{5, 3}, "blue"}
             ]
    end

    @tag tetro_name: :l
    test "when given a valid :l tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{2, 3}, "brown"},
               {{3, 3}, "brown"},
               {{4, 3}, "brown"},
               {{4, 4}, "brown"}
             ]
    end

    @tag tetro_name: :j
    test "when given a valid :j tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{2, 4}, "orange"},
               {{3, 4}, "orange"},
               {{4, 3}, "orange"},
               {{4, 4}, "orange"}
             ]
    end

    @tag tetro_name: :o
    test "when given a valid :o tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{2, 3}, "purple"},
               {{2, 4}, "purple"},
               {{3, 3}, "purple"},
               {{3, 4}, "purple"}
             ]
    end

    @tag tetro_name: :s
    test "when given a valid :s tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{3, 4}, "yellow"},
               {{3, 5}, "yellow"},
               {{4, 3}, "yellow"},
               {{4, 4}, "yellow"}
             ]
    end

    @tag tetro_name: :t
    test "when given a valid :t tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{2, 3}, "green"},
               {{3, 3}, "green"},
               {{4, 3}, "green"},
               {{3, 4}, "green"}
             ]
    end

    @tag tetro_name: :z
    test "when given a valid :z tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [
               {{3, 3}, "red"},
               {{3, 4}, "red"},
               {{4, 4}, "red"},
               {{4, 5}, "red"}
             ]
    end

    test "when given a valid tetro rotated, covert to group", ctx do
      assert ctx.tetro
             |> Tetromino.rotate()
             |> Tetromino.to_group() == [
               {{3, 5}, "blue"},
               {{3, 4}, "blue"},
               {{3, 3}, "blue"},
               {{3, 2}, "blue"}
             ]
    end

    test "when given a valid tetro moved, covert to group", ctx do
      assert ctx.tetro
             |> Tetromino.fall()
             |> Tetromino.left()
             |> Tetromino.right()
             |> Tetromino.to_group() == [
               {{3, 3}, "blue"},
               {{4, 3}, "blue"},
               {{5, 3}, "blue"},
               {{6, 3}, "blue"}
             ]
    end
  end
end
