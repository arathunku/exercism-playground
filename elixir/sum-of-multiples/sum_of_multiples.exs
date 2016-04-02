defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(&(multiples_upto(&1, limit-1)))
    |> List.flatten
    |> Enum.uniq
    |> Enum.sum
  end

  defp multiples_upto(factor, limit) do
    for v <- 0..limit, rem(v, factor) == 0, do: v
  end
end
