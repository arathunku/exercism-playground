defmodule Scrabble do
  @scores [{~w(A E I O U L N R S T), 1},
           {~w(D G), 2},
           {~w(B C M P), 3},
           {~w(F H V W Y), 4},
           {~w(K), 5},
           {~w(J X), 8},
           {~w(Q Z), 10}]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> Enum.reduce(0, fn (letter, acc) -> acc + score_for_letter(letter) end)
  end

  # Simple example of memoization,
  # because I can and I want to try different techniques in Elixir :)
  def score_for_letter(letter) do
    case :erlang.get(:scores) do
      :undefined ->
        scores = @scores
        |> Enum.reduce(%{}, fn ({letters, score}, acc) ->
          letters
          |> Enum.reduce(acc, fn (letter, acc) -> Map.merge(acc, %{letter => score}) end)
        end)
        :erlang.put(:scores, scores)

        Map.get(scores, letter, 0)
      scores -> Map.get(scores, letter, 0)
    end
  end
end
