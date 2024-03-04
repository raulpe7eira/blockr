defmodule Blockr.Game.GroupTest do
  use ExUnit.Case

  alias Blockr.Game.Group

  setup do
    %{points: [{2, 2}, {3, 2}, {4, 2}, {4, 3}]}
  end

  describe "move_down/1" do
    test "when given a valid points, move points to down", ctx do
      assert Group.move_down(ctx.points) == [{3, 2}, {4, 2}, {5, 2}, {5, 3}]
    end
  end

  describe "move_left/1" do
    test "when given a valid points, move points to left", ctx do
      assert Group.move_left(ctx.points) == [{2, 1}, {3, 1}, {4, 1}, {4, 2}]
    end
  end

  describe "move_right/1" do
    test "when given a valid points, move points to right", ctx do
      assert Group.move_right(ctx.points) == [{2, 3}, {3, 3}, {4, 3}, {4, 4}]
    end
  end

  describe "move_to/2" do
    test "when given a valid points and location, move points to location", ctx do
      assert Group.move_to(ctx.points, {3, 4}) == [{5, 6}, {6, 6}, {7, 6}, {7, 7}]
    end
  end

  describe "rotate/2" do
    test "when given a valid points and 0 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 0) == [{2, 2}, {3, 2}, {4, 2}, {4, 3}]
    end

    test "when given a valid points and 90 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 90) == [{2, 3}, {2, 2}, {2, 1}, {3, 1}]
    end

    test "when given a valid points and 180 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 180) == [{3, 3}, {2, 3}, {1, 3}, {1, 2}]
    end

    test "when given a valid points and 270 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 270) == [{3, 2}, {3, 3}, {3, 4}, {2, 4}]
    end
  end

  describe "paint/2" do
    test "when given a valid points and shape_name, return points w/ color", ctx do
      assert Group.paint(ctx.points, :i) == [
               {{2, 2}, "blue"},
               {{3, 2}, "blue"},
               {{4, 2}, "blue"},
               {{4, 3}, "blue"}
             ]
    end
  end
end
