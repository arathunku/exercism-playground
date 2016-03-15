defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/\b\w|\p{Lu}/u, string)
    |> Enum.map_join(&List.first/1)
    |> String.upcase()
  end
end
