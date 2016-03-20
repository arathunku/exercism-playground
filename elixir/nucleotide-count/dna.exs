defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

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

    strand
    |> Enum.filter(&(&1 == nucleotide))
    |> Enum.count
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
    |> Enum.reduce(default_nucleotides_counts, &count_nucleotide/2)
  end

  defp default_nucleotides_counts do
    @nucleotides
    |> Enum.reduce(%{}, &(Map.merge(&2, %{&1 => 0})))
  end

  defp count_nucleotide({k, v}, acc) do
    Map.merge(acc, %{k => length(v)})
  end

  defp valid_strand?(strand) do
    strand |> Enum.all?(&valid_nucletide?/1)
  end

  defp valid_nucletide?(nucleotide) do
    Enum.member?(@nucleotides, nucleotide)
  end
end
