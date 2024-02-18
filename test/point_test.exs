defmodule PointTest do
  use ExUnit.Case

  describe "new/2" do
    test "when given a valid row and col, create a new point" do
      assert Point.new(5, 6) == {5, 6}
    end
  end

  describe "move_down/1" do
    test "when given a valid point, moves point down" do
      assert Point.move_down({5, 6}) == {6, 6}
    end
  end

  describe "move_left/1" do
    test "when given a valid point, moves point left" do
      assert Point.move_left({5, 6}) == {5, 5}
    end
  end

  describe "move_right/1" do
    test "when given a valid point, moves point right" do
      assert Point.move_right({5, 6}) == {5, 7}
    end
  end
end
