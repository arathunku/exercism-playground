defmodule Queens do
  @default_positions [white: {0, 3}, black: {7, 3}]
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new(nil | list) :: Queens.t()
  def new() do
    new(@default_positions)
  end

  def new(white: white, black: black) when white == black, do: raise ArgumentError
  def new(white: white, black: black), do: %Queens{white: white, black: black}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for i <- 0..7 do
      for j <- 0..7 do
        cond do
          queens.white == {i, j} -> "W"
          queens.black == {i, j} -> "B"
          true -> "_"
        end
      end |> Enum.join(" ")
    end |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{white: white, black: black}) do
    column_match?(white, black) ||
      row_match?(white, black) ||
      diagonal_match?(white, black)
  end

  defp row_match?({x1, _}, {x2, _}), do: x1 == x2
  defp column_match?({_, y1}, {_, y2}), do: y1 == y2
  defp diagonal_match?({x1, y1}, {x2, y2}) do
    x1 - x2 == y1 - y2 || x1 - x2 == -(y1 - y2)
  end
end
