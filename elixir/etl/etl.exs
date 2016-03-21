defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Map) :: map()
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn ({k,v}, acc) ->
      Enum.reduce(v, acc, fn (v, acc) ->
        Map.update(acc,
                   String.downcase(v),
                   k,
                   &(&1 + 1))
      end)
    end)
  end
end
