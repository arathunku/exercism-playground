defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number) do
    factor(number, 2, [])
  end

  defp factor(number, maybe_prime, acc) when number < maybe_prime * maybe_prime do
    [number | acc] |> Enum.reverse
  end

  defp factor(number, maybe_prime, acc) when rem(number, maybe_prime) == 0 do
    factor(div(number, maybe_prime), maybe_prime, [maybe_prime | acc])
  end

  defp factor(number, maybe_prime, acc) do
    factor(number, maybe_prime + 1, acc)
  end
end
