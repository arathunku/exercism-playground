defmodule Squares do
  @moduledoc """
  Calculate sum of squares, square of sums, difference between two sums from 1 to a given end number.
  """

  @doc """
  Calculate sum of squares from 1 to a given end number.
  """
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(number) do
    (1..number)
    |> Enum.map(&(:math.pow(&1, 2)))
    |> Enum.sum
  end

  @doc """
  Calculate square of sums from 1 to a given end number.
  """
  @spec square_of_sums(pos_integer) :: pos_integer
  def square_of_sums(number) do
    (1..number)
    |> Enum.sum
    |> :math.pow(2)
  end

  @doc """
  Calculate difference between sum of squares and square of sums from 1 to a given end number.
  """
  @spec difference(pos_integer) :: pos_integer
  def difference(number) do
    abs(sum_of_squares(number) - square_of_sums(number))
  end
end