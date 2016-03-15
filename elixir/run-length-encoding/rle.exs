defmodule RunLengthEncoder do
  require Logger
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> prepare_input
    |> Enum.chunk_by(&(&1))
    |> Enum.map_join(&("#{length(&1)}#{hd(&1)}"))
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> prepare_input
    |> Enum.chunk(2)
    |> Enum.reduce("", fn ([count | letters], acc) ->
      acc <> String.duplicate(List.first(letters), String.to_integer(count))
    end)
  end

  defp prepare_input(v) do
    Regex.scan(~r/\D|\d+/, v)
    |> Enum.map(&List.first/1)
    |> Enum.filter(&(&1 != ""))
  end
end
