defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    downcased_base = String.downcase(base)
    prepared_base = prepare_str(base)

    candidates
    |> Enum.filter(fn (v) -> String.downcase(v) != downcased_base end)
    |> Enum.filter(fn (v) -> prepare_str(v) === prepared_base end)
  end

  defp prepare_str(str) do
    str
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.sort
  end
end
