defmodule Atbash do
  @plain "abcdefghijklmnopqrstuvwxyz"
  @cipher Map.new Enum.zip(@plain |> String.graphemes,
                           @plain |> String.graphemes |> Enum.reverse)

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    Regex.scan(~r/[A-Za-z0-9]/, plaintext |> String.downcase)
    |> List.flatten
    |> Enum.map(&(@cipher[&1] || &1))
    |> Enum.chunk(5, 5, [])
    |> Enum.join(" ")
  end
end
