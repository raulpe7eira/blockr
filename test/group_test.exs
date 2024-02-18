defmodule GroupTest do
  use ExUnit.Case

  setup do
    points =
      [
        Point.new(2, 2),
        Point.new(3, 2),
        Point.new(4, 2),
        Point.new(4, 3)
      ]

    %{points: points}
  end

  describe "move_down/1" do
    test "when given a valid points, move points to down", ctx do
      assert Group.move_down(ctx.points) == [
               Point.new(3, 2),
               Point.new(4, 2),
               Point.new(5, 2),
               Point.new(5, 3)
             ]
    end
  end

  describe "move_left/1" do
    test "when given a valid points, move points to left", ctx do
      assert Group.move_left(ctx.points) == [
               Point.new(2, 1),
               Point.new(3, 1),
               Point.new(4, 1),
               Point.new(4, 2)
             ]
    end
  end

  describe "move_right/1" do
    test "when given a valid points, move points to right", ctx do
      assert Group.move_right(ctx.points) == [
               Point.new(2, 3),
               Point.new(3, 3),
               Point.new(4, 3),
               Point.new(4, 4)
             ]
    end
  end

  describe "rotate/2" do
    test "when given a valid points and 0 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 0) == [
               Point.new(2, 2),
               Point.new(3, 2),
               Point.new(4, 2),
               Point.new(4, 3)
             ]
    end

    test "when given a valid points and 90 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 90) == [
               Point.new(2, 3),
               Point.new(2, 2),
               Point.new(2, 1),
               Point.new(3, 1)
             ]
    end

    test "when given a valid points and 180 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 180) == [
               Point.new(3, 3),
               Point.new(2, 3),
               Point.new(1, 3),
               Point.new(1, 2)
             ]
    end

    test "when given a valid points and 270 degrees, rotate the points", ctx do
      assert Group.rotate(ctx.points, 270) == [
               Point.new(3, 2),
               Point.new(3, 3),
               Point.new(3, 4),
               Point.new(2, 4)
             ]
    end
  end
end
