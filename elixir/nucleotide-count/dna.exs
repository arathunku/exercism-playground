defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]
  @default_histogram @nucleotides |> Enum.reduce(%{}, &(Map.merge(&2, %{&1 => 0})))
  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if !valid_strand?(strand) || !valid_nucletide?(nucleotide) do
      raise ArgumentError
    end

    strand |> Enum.count(&(&1 == nucleotide))
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Map
  def histogram(strand) do
    if !valid_strand?(strand) do
      raise ArgumentError
    end

    strand
    |> Enum.group_by(&(&1))
    |> Enum.reduce(@default_histogram, &count_nucleotide/2)
  end

  defp count_nucleotide({k, v}, acc) do
    Map.merge(acc, %{k => length(v)})
  end

  defp valid_strand?(strand), do: Enum.all?(strand, &valid_nucletide?/1)

  defp valid_nucletide?(nucleotide) when nucleotide in @nucleotides, do: true
  defp valid_nucletide?(nucleotide), do: false
end
