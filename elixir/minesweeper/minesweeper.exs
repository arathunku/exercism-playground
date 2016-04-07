defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    board = deserialize(board)
    mines = extract_mines(board)

    board
    |> Enum.map(fn ({row, y}) ->
      Enum.map(row, fn {v, x} ->
        result = matched_mines({x, y}, mines)
        if(v == " " && result > 0, do: result, else: v)
      end)
      |> Enum.join
    end)
  end

  def extract_mines(board) do
    Enum.reduce(board, [], fn({row, y}, acc) ->
      mines = row
      |> Enum.filter(&(elem(&1, 0) == "*"))
      |> Enum.map(fn {v, x} -> {v, x, y} end)

      mines ++ acc
    end)
  end

  def deserialize(board) do
    Enum.map(board, &(String.split(&1, "")))
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index
  end

  def matched_mines(pos, mines) do
    mines
    |> Enum.filter(fn {_, x, y} ->
      row_match?(pos, {x, y}) || column_match?(pos, {x, y}) || diagonal_match?(pos, {x,y})
    end)
    |> Enum.count
  end

  defp row_match?({x1, y1}, {x2, y2}), do: abs(x2-x1) == 1 && y1 == y2
  defp column_match?({x2, y1}, {x1, y2}), do: abs(y2-y1) == 1 && x1 == x2
  defp diagonal_match?({x1, y1}, {x2, y2}) do
    abs(y2-y1) == 1 && abs(x2-x1) == 1
  end
end
