defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number), do: square(number, 1)
  defp square(1, acc), do: acc
  defp square(number, acc) do
    square(number - 1, acc * 2)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    square(65) - 1
  end
end
