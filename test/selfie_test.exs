defmodule SelfieTest do
  use ExUnit.Case
  import Selfie

  defmodule Pair do
    defstruct x: 3, y: 4

    def sum(%Pair{x: x, y: y}), do: x + y

    def sum_modulo(pair, divisor), do: rem(sum(pair), divisor)
  end

  doctest(Selfie)

  test "raises UndefinedFunctionError when there are multiple args and no match" do
    assert_raise UndefinedFunctionError, fn ->
      %Pair{x: 1, y: 1} |> self_apply(:foo, ["bar"])
    end
  end

  test "raises KeyError when there is no function or field" do
    assert_raise KeyError, fn ->
      %Pair{x: 1, y: 1} |> self_apply(:foo)
    end
  end

  test "raises FunctionClauseError when `args` is not a list" do
    assert_raise FunctionClauseError, fn ->
      %Pair{x: 1, y: 1} |> self_apply(:foo, :bar)
    end
  end
end
