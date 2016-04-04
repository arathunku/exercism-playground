defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) when size < 0 or byte_size(number_string) < size do
    raise ArgumentError
  end
  def largest_product(number_string, 0), do: 1
  def largest_product(number_string, size) do
    number_string
    |> String.graphemes
    |> Enum.chunk(size, 1)
    |> Enum.map(&calculate_product/1)
    |> (&(if &1 == [], do: 1, else: Enum.max(&1))).()
  end

  defp calculate_product(list_of_numbers) do
    list_of_numbers
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(1, &(&1 * &2))
  end
end
