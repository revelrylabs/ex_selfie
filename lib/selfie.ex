# Copyright Revelry Labs, LLC (2018)

defmodule Selfie do
  @moduledoc """
  Provides a single way to access both a struct's fields and its associated module's functions.

  Elixir structs know what module they belong to.
  `Kernel.apply/3` lets you dynamically call module functions.
  Selfie takes advantage to let you play fast and loose with structs.

  ## Warning: Dynamic function calls should often be avoided

  Static analysis is a beautiful thing, and dynamic calls take some of that away.
  Be judicious about where you choose to use or not use Selfie.
  Where you wouldn't use `Kernel.apply/3`, don't use `Selfie.self_apply/3`.
  """

  @doc """
  Return the result of a struct field lookup or struct module function call.

  ## Arguments

  `struct` - Any Elixir struct.

  `name` - The name of a struct field or a function on the struct module.

  `args_list` - An optional list of arguments to be passed in the case of a struct module function call.

  ## Example

  Define a struct module that includes some functions which take the struct as their first argument:

      defmodule SelfieTest.Pair do
        defstruct x: nil, y: nil

        def sum(%Pair{x: x, y: y}), do: x + y

        def sum_modulo(pair, divisor), do: sum(pair) |> rem(divisor)
      end

  Selfie normalizes dynamic access to both fields and module functions.
  You can access a struct field:

      iex> %Pair{x: 3, y: 4} |> self_apply(:x)
      3

  You can call a one-argument struct module function:

      iex> %Pair{x: 3, y: 4} |> self_apply(:sum)
      7

  You can call a multi-argument struct module function:

      iex> %Pair{x: 3, y: 4} |> self_apply(:sum_modulo, [6])
      1
  """
  def self_apply(%{__struct__: module_name} = struct, name, args_list \\ [])
      when is_atom(name) and is_list(args_list) do
    try do
      apply(module_name, name, [struct | args_list])
    rescue
      error in UndefinedFunctionError -> handle_undefined(struct, name, args_list, error)
    end
  end

  defp handle_undefined(struct, name, [], _), do: Map.fetch!(struct, name)

  defp handle_undefined(_, _, _, error), do: raise(error)
end
