defmodule Allergies do
  use Bitwise
  @allergies [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
  ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    @allergies
    |> Enum.reduce_while({flags, []}, fn (name, acc={flags, allergies}) ->
      cond do
        flags == 0 -> {:halt, acc}
        (flags &&& 1) == 0 -> {:cont, {flags >>> 1, allergies}}
        true -> {:cont, {flags >>> 1, [name | allergies]}}
      end
    end)
    |> elem(1)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    !!(flags |> list |> Enum.find(&(&1 == item)))
  end
end
