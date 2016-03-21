defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna |> Enum.map(&replace_nucleotide/1)
  end

  defp replace_nucleotide(?G), do: ?C
  defp replace_nucleotide(?A), do: ?U
  defp replace_nucleotide(?T), do: ?A
  defp replace_nucleotide(?C), do: ?G
  defp replace_nucleotide(_), do: raise ArgumentError
end
