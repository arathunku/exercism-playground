defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    get_primes(Enum.to_list(2..limit), [])
  end

  defp get_primes([ prime | [] ], primes) do
    [prime | primes] |> Enum.reverse
  end

  defp get_primes([ prime | tail ], primes) do
    get_primes(
      Enum.reject(tail, &(rem(&1, prime) == 0)),
      [prime | primes]
    )
  end
end
