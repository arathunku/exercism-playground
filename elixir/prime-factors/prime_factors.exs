defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factor(number, 2, []) |> Enum.reverse
  end

  defp factor(1, _, acc), do: acc
  defp factor(number, maybe_prime, acc) do
    case rem(number, maybe_prime) do
      0 -> factor(div(number, maybe_prime), maybe_prime, [maybe_prime | acc])
      _ -> factor(number, maybe_prime + 1, acc)
    end
  end
end
