defmodule KbtTest do
  use ExUnit.Case
  doctest Kbt

  test "greets the world" do
    assert Kbt.hello() == :world
  end
end
