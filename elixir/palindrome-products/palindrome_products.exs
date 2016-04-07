defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    product_palindromes(max_factor, min_factor)
    |> Enum.reduce(%{}, fn ({product, y, x}, acc) ->
      Map.merge(acc, %{product => [[x, y]]}, fn (_k, v1, v2) ->
        v1 ++ v2 |> Enum.uniq
      end)
    end)
  end

  defp palindrome?(n) do
    n == String.reverse(n)
  end

  def product_palindromes(min, max) do
    for x <- min..max,
        y <- x..max,
        product = x * y,
        palindrome?(to_string(product)),
        into: [],
        do: { product, x, y }
  end
end
