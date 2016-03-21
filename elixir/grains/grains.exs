defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number), do: square(number, 1)
  def square(0, acc), do: acc
  def square(1, acc), do: acc
  def square(number, acc) do
    square(number - 1, acc * 2)
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    Enum.reduce(1..64, 0, &(&2 + square(&1)))
  end
end
