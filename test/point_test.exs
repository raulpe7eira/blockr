defmodule PointTest do
  use ExUnit.Case

  setup do
    %{point: {1, 2}}
  end

  describe "new/2" do
    test "when given a valid row and col, create a new point" do
      assert Point.new(5, 6) == {5, 6}
    end
  end

  describe "move_down/1" do
    test "when given a valid point, move point to down", ctx do
      assert Point.move_down(ctx.point) == {2, 2}
    end
  end

  describe "move_left/1" do
    test "when given a valid point, move point to left", ctx do
      assert Point.move_left(ctx.point) == {1, 1}
    end
  end

  describe "move_right/1" do
    test "when given a valid point, move point to right", ctx do
      assert Point.move_right(ctx.point) == {1, 3}
    end
  end

  describe "rotate/2" do
    test "when given a valid point and 0 degrees, rotate the point", ctx do
      assert Point.rotate(ctx.point, 0) == {1, 2}
    end

    test "when given a valid point and 90 degrees, rotate the point", ctx do
      assert Point.rotate(ctx.point, 90) == {2, 4}
    end

    test "when given a valid point and 180 degrees, rotate the point", ctx do
      assert Point.rotate(ctx.point, 180) == {4, 3}
    end

    test "when given a valid point and 270 degrees, rotate the point", ctx do
      assert Point.rotate(ctx.point, 270) == {3, 1}
    end
  end
end
