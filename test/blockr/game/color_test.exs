defmodule Blockr.Game.ColorTest do
  use ExUnit.Case

  alias Blockr.Game.Color

  describe "for/1" do
    test "when given :i shape, return blue" do
      assert Color.for(:i) == "blue"
    end

    test "when given :l shape, return brown" do
      assert Color.for(:l) == "brown"
    end

    test "when given :j shape, return orange" do
      assert Color.for(:j) == "orange"
    end

    test "when given :o shape, return purple" do
      assert Color.for(:o) == "purple"
    end

    test "when given :s shape, return yellow" do
      assert Color.for(:s) == "yellow"
    end

    test "when given :t shape, return green" do
      assert Color.for(:t) == "green"
    end

    test "when given :z shape, return red" do
      assert Color.for(:z) == "red"
    end
  end
end
