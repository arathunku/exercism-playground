defmodule CustomSet do
  # This lets the compiler check that all Set callback functions have been
  # implemented.
  @behaviour Set
  defstruct map: %{}

  def new(), do: new([])
  def new(elements) do
    Enum.reduce(elements, %CustomSet{}, &(put(&2, &1)))
  end

  def delete(s = %CustomSet{map: map}, k) do
    %CustomSet{ s | map: Map.delete(map, k) }
  end

  def equal?(s1, s2) do
    keys(s1) == keys(s2)
  end

  def difference(s1, s2) do
    new(keys(s1) -- keys(s2))
  end

  def disjoint?(s1, s2) do
    s1_keys = keys(s1)

    s1_keys -- keys(s2) == s1_keys
  end

  def empty(_) do
    new
  end

  def intersection(s, %CustomSet{map: m2}) do
    new(keys(s) |> Enum.filter(&(Map.get(m2, &1))))
  end

  def member?(%CustomSet{map: map}, k) do
    !!Map.get(map, k)
  end

  def put(s = %CustomSet{map: map}, k) do
    %CustomSet{ s | map: Map.put(map, k, true) }
  end

  def size(s), do: keys(s) |> length

  def subset?(s, %CustomSet{map: m2}) do
    0 == (keys(s) |> Enum.reject(&(Map.get(m2, &1))) |> Enum.count)
  end

  def union(s1, s2) do
    new(keys(s1) ++ keys(s2))
  end

  def to_list(s), do: keys(s)

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(set, opts) do
      concat ["%CustomSet{list: ", Inspect.List.inspect(CustomSet.to_list(set), opts), "}"]
    end
  end

  defp keys(%CustomSet{map: map}), do: Map.keys(map)
end
