defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.split("", trim: true)
    |> Enum.map(fn (el) ->
      cond do
       el == "1" || el == "0" -> String.to_integer(el)
       true -> raise ArgumentError
      end
    end)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0, fn ({v, power}, acc) -> acc + (v * :math.pow(2, power)) end)
    rescue ArgumentError -> 0
  end
end
