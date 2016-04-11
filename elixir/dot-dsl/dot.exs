defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(do: nil), do: Macro.escape(%Graph{})
  defmacro graph(do: ast) do
    IO.inspect ast
    ast
    |> parse(%Graph{attrs: [], nodes: [], edges: []})
    |> Macro.escape
  end

  defp parse({:__block__, _, lines}, acc) do
    Enum.reduce(lines, acc, &parse/2)
  end


  defp parse({:graph, _, [gattrs]}, acc) do
    sort_merge_keyword(acc, :attrs, gattrs)
  end


  defp parse({:--, _, [{a, _, _}, {b, _, [keywords]}]}, acc) when is_atom(b) do
    sort_merge_keyword(acc, :edges, [{a, b, keywords}])
  end

  defp parse({:--, _, [{a, _, _}, {b, _, nil}]}, acc) do
    sort_merge_keyword(acc, :edges, [{a, b, []}])
  end


  defp parse({v, _, [keywords]}, acc) when v != :. and is_list(keywords) do
    Enum.each(keywords, &(if(!is_tuple(&1), do: raise ArgumentError)))

    sort_merge_keyword(acc, :nodes, [{v, keywords}])
  end

  defp parse({v, _, nil}, acc) when v != :. and is_atom(v) do
    sort_merge_keyword(acc, :nodes, [{v, []}])
  end


  defp parse(_, _), do: raise ArgumentError

  defp sort_merge_keyword(m, k, v) do
    Map.merge(m, %{k => Map.get(m, k) ++ v |> Enum.sort })
  end
end
