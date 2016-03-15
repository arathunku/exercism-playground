defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn (_, acc) -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: for(v <- l, do: f.(v))

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: (for v <- l, f.(v), do: v)

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, f), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append(a, []), do: a
  def append([], b), do: b
  def append([head | tail], b), do: [ head | append(tail, b) ]

  @spec concat([[any]]) :: [any]
  def concat(ll), do: concat(ll, [])
  defp concat([], acc), do: reverse(acc)
  defp concat([head | tail], acc), do: concat(tail, reduce(head, acc, &([&1 | &2])))
end
