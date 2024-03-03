defmodule TetrominoTest do
  use ExUnit.Case

  setup(ctx) do
    name = Map.get(ctx, :tetro_name, :i)

    %{tetro: %Tetromino{name: name, location: {1, 1}, rotation: 0, color: :green}}
  end

  describe "new/0" do
    test "when call new, create a new tetromino" do
      assert Tetromino.new() == %Tetromino{
               name: :i,
               location: {1, 1},
               rotation: 0,
               color: :green
             }
    end
  end

  describe "new/1" do
    test "when given a valid name, create a new tetromino" do
      assert Tetromino.new(:z) == %Tetromino{
               name: :z,
               location: {1, 1},
               rotation: 0,
               color: :green
             }
    end
  end

  describe "fall/1" do
    test "when given a valid tetro, move tetro to fall", ctx do
      assert Tetromino.fall(ctx.tetro) == %Tetromino{
               name: :i,
               location: {2, 1},
               rotation: 0,
               color: :green
             }
    end
  end

  describe "left/1" do
    test "when given a valid tetro, move tetro to left", ctx do
      assert Tetromino.left(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 0},
               rotation: 0,
               color: :green
             }
    end
  end

  describe "right/1" do
    test "when given a valid tetro, move tetro to right", ctx do
      assert Tetromino.right(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 2},
               rotation: 0,
               color: :green
             }
    end
  end

  describe "rotate/1" do
    test "when given a valid tetro, rotate tetro to 90 degrees to right", ctx do
      assert Tetromino.rotate(ctx.tetro) == %Tetromino{
               name: :i,
               location: {1, 1},
               rotation: 90,
               color: :green
             }

      assert Enum.reduce(1..2, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 180,
                 color: :green
               }

      assert Enum.reduce(1..3, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 270,
                 color: :green
               }

      assert Enum.reduce(1..4, ctx.tetro, fn _, tetro -> Tetromino.rotate(tetro) end) ==
               %Tetromino{
                 name: :i,
                 location: {1, 1},
                 rotation: 0,
                 color: :green
               }
    end
  end

  describe "to_group/1" do
    test "when given a valid :i tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{1, 2}, {2, 2}, {3, 2}, {4, 2}]
    end

    @tag tetro_name: :l
    test "when given a valid :l tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{1, 2}, {2, 2}, {3, 2}, {3, 3}]
    end

    @tag tetro_name: :j
    test "when given a valid :j tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{1, 3}, {2, 3}, {3, 2}, {3, 3}]
    end

    @tag tetro_name: :o
    test "when given a valid :o tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{1, 2}, {1, 3}, {2, 2}, {2, 3}]
    end

    @tag tetro_name: :s
    test "when given a valid :s tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{2, 3}, {2, 4}, {3, 2}, {3, 3}]
    end

    @tag tetro_name: :t
    test "when given a valid :t tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{1, 2}, {2, 2}, {3, 2}, {2, 3}]
    end

    @tag tetro_name: :z
    test "when given a valid :z tetro, covert to group", ctx do
      assert Tetromino.to_group(ctx.tetro) == [{2, 2}, {2, 3}, {3, 3}, {3, 4}]
    end

    test "when given a valid tetro rotated, covert to group", ctx do
      assert ctx.tetro
             |> Tetromino.rotate()
             |> Tetromino.to_group() == [{2, 4}, {2, 3}, {2, 2}, {2, 1}]
    end
  end
end
