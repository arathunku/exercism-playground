defmodule Bob do
  @shout_response "Whoa, chill out!"
  @question_response "Sure."
  @all_else_response "Whatever."
  @silence_response "Fine. Be that way!"

  @spec hey(String.t) :: String.t
  def hey(input) do
    cond do
      silence?(input) -> @silence_response
      shout?(input) -> @shout_response
      question?(input) -> @question_response
      true -> @all_else_response
    end
  end

  defp silence?(v) do
    String.strip(v) == ""
  end

  defp shout?(v) do
    String.upcase(v) == v && String.downcase(v) != v
  end

  defp question?(v) do
    String.ends_with?(v, "?")
  end
end
