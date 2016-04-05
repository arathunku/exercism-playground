defmodule BracketPush do
  @brackets %{"{" => "}",
              "(" => ")",
              "[" => "]"}
  @pushables Map.keys(@brackets)
  @popables Map.values(@brackets)

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    act(str |> String.graphemes, [])
  end

  defp act([], []), do: true
  defp act([], _), do: false
  defp act([bracket | brackets], stack) when bracket in @pushables do
    act(brackets, [ bracket | stack ])
  end
  defp act([bracket | _], []) when bracket in @popables, do: false
  defp act([bracket | brackets], [ head | tail]) when bracket in @popables do
    bracket == @brackets[head] && act(brackets, tail)
  end
  defp act([_ | brackets], stack) do
    act(brackets, stack)
  end
end
