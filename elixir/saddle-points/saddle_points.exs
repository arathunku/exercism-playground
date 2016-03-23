defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&parse_row/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> transpose
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    for {max, x} <- max_row_points(str), {min, y} <- min_column_points(str), max == min do
      { x, y }
    end
  end

  defp max_row_points(str) do
    rows(str) |> Enum.map(&Enum.max/1) |> Enum.with_index
  end

  defp min_column_points(str) do
    columns(str) |> Enum.map(&Enum.min/1) |> Enum.with_index
  end

  defp transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp parse_row(row) do
    row
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end
end
