defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) do
    sorted_a = Enum.sort(a)
    sorted_b = Enum.sort(b)
    case Enum.length(sorted_a) == Enum.length(sorted_b) do
      true -> sorted_b
      false -> {}
    end
  end
end
