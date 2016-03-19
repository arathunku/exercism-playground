defmodule Sublist do
  require Logger
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when length(a) == length(b), do: compare(a,b, :equal)
  def compare(a, b) when length(a) > length(b), do: compare(b, a, :superlist)
  def compare(a, b) when length(a) < length(b), do: compare(a, b, :sublist)

  def compare(a, b, resp)do
    if comparep(a, b) == :ok do
      resp
    else
      if length(a) == length(b) do
        :unequal
      else
        [_ | tail] = b
        compare(a, tail, resp)
      end
    end
  end

  def comparep([], []), do: :ok
  def comparep([], _), do: :ok
  def comparep(_, []), do: :ok
  def comparep([a_head | a_tail], [b_head | b_tail]) do
    if a_head === b_head do
      comparep(a_tail, b_tail)
    else
      :err
    end
  end
end
























# def comparep(a = [a_head | a_tail], b = [b_head | b_tail], resp) do
#   if a_head === b_head do
#     IO.inspect [true, a, b]

#     case comparep(a_tail, b_tail, resp) do
#       {:unequal, tail} ->
#         IO.inspect ["start over", a, tail]
#         comparep(a, tail, resp)
#       {res, v} -> {res, v}
#     end
#   else
#     IO.inspect [false, a, b]
#     {:unequal, b}
#   end
# end
