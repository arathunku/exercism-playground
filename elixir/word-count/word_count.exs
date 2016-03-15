defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  Words are considered to be any valid regexp word characters or hyphens
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
    |> String.downcase
    |> split_to_words
    |> count_words
  end

  defp split_to_words(v) do
    Regex.split(~r/([^\w+-]|_)/u, v, trim: true)
  end

  defp count_words(v) do
    Enum.reduce(v, %{}, fn (k, acc) ->
      Map.update(acc, k, 1, &(&1 + 1))
    end)
  end
end
