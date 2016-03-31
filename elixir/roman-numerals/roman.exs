defmodule Roman do
  @roman_dec [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    @roman_dec
    |> Enum.reduce({number, []}, &check_number/2)
    |> elem(1)
    |> Enum.reverse
    |> Enum.join
  end

  defp check_number(roman={number, symbol}, result={current_number, acc}) do
    if current_number >= numberssss do
      check_number(roman, {current_number - number, [symbol | acc]})
    else
      result
    end
  end
end
