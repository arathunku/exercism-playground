defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board
  using "O" as the white player
  and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(["X"]), do: :black
  def result_for(["O"]), do: :white
  def result_for(board) do
    graph = :digraph.new()
    board = board |> deserialize |> add_vertices(graph)
    dims = board_dimensions(board)

    board |> add_edges(graph, dims)

    cond do
      check_white(graph, dims) -> :white
      check_black(graph, dims) -> :black
      true -> :none
    end
  end

  def board_dimensions(board) do
    { board |> List.first |> Enum.count, Enum.count(board) }
  end

  def check_white(graph, {_, height}) do
    check(graph,
          match_nodes(graph, {"O", nil, 0}),
          match_nodes(graph, {"O", nil, height - 1}))
  end

  def check_black(graph, {width, _}) do
    check(graph,
          match_nodes(graph, {"X", 0, nil}),
          match_nodes(graph, {"X", width - 1, nil}))
  end

  def check(_, [], _), do: nil
  def check(_, _, []), do: nil
  def check(graph, start_vertices, end_vertices) do
    Enum.reduce_while(start_vertices, nil, fn (start, _) ->
      Enum.reduce_while(end_vertices, nil, fn (v, _) ->
        path = :digraph.get_path(graph, start, v)
        if(path, do: {:halt, {:halt, path}}, else: {:cont, {:cont, nil}})
      end)
    end)
  end

  def deserialize(board) do
    board
    |> Enum.map(fn row ->
      row
      |> String.graphemes
      |> Enum.with_index
    end)
    |> Enum.with_index
  end

  def add_vertices(board, graph) do
    Enum.map(board, fn {row, y} ->
      Enum.map(row, fn {v, x} ->
        :digraph.add_vertex(graph, {v, x, y})
      end)
    end)
  end

  def add_edges(board, graph, dims) do
    Enum.each(board, fn row ->
      Enum.each(row, fn v ->
        Enum.each(get_neighbours_of(board, v, dims), fn(neighbour) ->
          :digraph.add_edge(graph, v, neighbour)
        end)
      end)
    end)

    board
  end

  def get_neighbours_of(board, {v, x, y}, { width, height}) do
    indexes = [
      { x, y - 1 }, { x + 1, y - 1},
      { x - 1, y }, { x + 1, y},
      { x - 1, y + 1 }, { x, y + 1}
    ]

    indexes
    |> Enum.filter(fn {x, y} -> x >= 0 && x < width && y >= 0 && y < height end)
    |> Enum.map(fn {x, y} ->
      row = Enum.at(board, y)
      if row do
        vertex = Enum.at(row, x)
        if(vertex && elem(vertex, 0) == v, do: vertex, else: nil)
      else
        nil
      end
    end)
    |> Enum.filter(&(&1))
  end

  def match_nodes(graph, {v, x, y}) do
    :digraph.vertices(graph)
    |> Enum.filter(fn {vv, xx, yy} ->
      vv == v && if(x != nil, do: xx == x, else: yy == y)
    end)
  end
end
