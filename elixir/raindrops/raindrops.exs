defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
    """
  @prime_factors [3,5,7]
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    @prime_factors
    |> Enum.filter(&(rem(number, &1) == 0))
    |> Enum.map(&number_to_rainspeak/1)
    |> Enum.join
    |> (&(if &1 == "", do: Integer.to_string(number), else: &1)).()
  end


  defp number_to_rainspeak(n) when n == 3, do: "Pling"
  defp number_to_rainspeak(n) when n == 5, do: "Plang"
  defp number_to_rainspeak(n) when n == 7, do: "Plong"
  defp number_to_rainspeak(_), do: nil
end
