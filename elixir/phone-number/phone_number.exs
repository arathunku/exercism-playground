defmodule Phone do
  @invalid_number "0000000000"
  @invalid_area_code "000"
  @invalid_pretty "(000) 000-0000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    case parse_number(raw) do
      {:ok, number} -> number
      {:err, _ } -> @invalid_number
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    case parse_number(raw) do
      {:ok, number} -> String.slice(number, 0, 3)
      {:err, _ } -> @invalid_area_code
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    case parse_number(raw) do
      {:ok, number} ->
        "(#{String.slice(number, 0..2)}) #{String.slice(number, 3..5)}-#{String.slice(number, 6..-1)}"
      {:err, _ } -> @invalid_pretty
    end
  end

  def parse_number(str) do
    number = Regex.scan(~r/\d+/, str) |> Enum.join
    cond do
      Regex.scan(~r/([A-Z|a-b]+)/, str) != [] -> {:err, "Number contains invalid characters"}
      String.length(number) == 11 and String.first(number) == "1" ->
        {:ok, String.slice(number, 1..-1)}
      String.length(number) == 10 ->
        {:ok, number}
      true ->
        {:err, "Number has incorrect length"}
    end
  end
end
