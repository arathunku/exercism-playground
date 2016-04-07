defmodule Frequency do
  @timeout 30000

  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts), do: frequency(texts, 1)
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    chunk = div(Enum.count(texts), workers)
    chunk = if(chunk == 0, do: 1, else: chunk)

    require Logger
    Logger.info("Workers: #{workers} | tasks: #{texts |> Enum.chunk(chunk, chunk, []) |> Enum.count}, texts: #{Enum.count(texts)}")

    texts
    |> Enum.chunk(chunk, chunk, [])
    |> Enum.map(fn (texts) -> Task.async(fn -> process_texts(texts) end) end)
    |> Task.yield_many(@timeout)
    |> Enum.map(fn ({task, res}) ->
      if res do
        elem(res, 1)
      else
        Task.shutdown(task, :brutal_kill)
        %{}
      end
    end)
    |> reduce_freq_map
  end

  defp process_texts(texts) do
    texts
    |> Enum.map(&do_freq/1)
    |> reduce_freq_map
  end

  defp do_freq(text) do
    text
    |> String.replace(~r/[0-9,\.\?;!\s]/, "")
    |> String.downcase
    |> String.graphemes
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {k, v} -> {k, length(v)} end)
  end


  defp reduce_freq_map(v, acc\\%{}) do
    Enum.reduce(v, acc, fn (text_freq, acc) ->
      Enum.reduce(text_freq, acc, fn ({k, v}, acc) ->
        Map.merge(acc, %{k => v} , fn (_, v1, v2) -> v1 + v2 end)
      end)
    end)
  end
end
