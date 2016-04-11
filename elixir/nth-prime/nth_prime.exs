defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count <= 0, do: raise ArgumentError
  def nth(1), do: 2
  def nth(count), do: nth(count, 3)

  defp nth(i, current_number) when i == 1, do: current_number - 2
  defp nth(i, current_number) do
    if prime?(current_number) do
      nth(i-1, current_number+2)
    else
      nth(i, current_number+2)
    end
  end

  defp prime?(n) do
    finish_at = :math.sqrt(n) |> round
    !Enum.any?((2..finish_at), &(rem(n, &1) == 0))
  end
end
