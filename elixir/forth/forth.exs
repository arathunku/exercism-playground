defmodule Forth do
  @opaque evaluator :: %{}

  defstruct dict: %{}, stack: []

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{stack: [], dict: %{}}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, s) do
    case String.first(s) do
      ":" ->
        [ word_definition | t] = String.split(s, ";", trim: true)
        ev = define_word(ev, word_definition)

        if(t, do: eval(ev, Enum.join(t, " ")), else: ev)
      _ -> eval_expression(ev, s)
    end
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(%Forth{stack: stack}) do
    stack |> Enum.reverse |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception [:message]
    def exception(_), do: %StackUnderflow{message: "stack underflow"}
  end

  defmodule InvalidWord do
    defexception [:message]
    def exception(word), do: %InvalidWord{message: "invalid word: #{inspect word}"}
  end

  defmodule UnknownWord do
    defexception [:message]
    def exception(word), do: %UnknownWord{message: "unknown word: #{inspect word}"}
  end

  defmodule DivisionByZero do
    defexception [:message]
    def exception(_), do: %DivisionByZero{message: "division by zero"}
  end

  defp define_word(ev=%Forth{dict: dict}, s) do
    [":", name | body] = s |> String.split(" ", trim: true)

    if Regex.match?(~r/^\d+$/, name) do
      raise Forth.InvalidWord, name
    else
      %Forth{ ev | dict: Map.merge(dict, %{ name => Enum.join(body, " ") }) }
    end
  end

  defp eval_expression(ev, s) do
    Regex.split(~r/[^\p{L}\p{N}\p{S}\p{P}]+/u, s, trim: true)
    |> List.flatten
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&String.strip/1)
    |> Enum.reduce(ev, fn (exp, ev=%Forth{dict: dict}) ->
      word_definition = Map.get(dict, exp)
      if word_definition do
        eval(ev, word_definition)
      else
        evaluate(ev, exp)
      end
    end)
  end

  defp evaluate(%Forth{stack: stack}, s) when s in ["/", "*", "+", "-"] and length(stack) < 2 do
    raise Forth.StackUnderflow
  end

  defp evaluate(ev=%Forth{stack: [ a, b | t ]}, s) when s in ["/", "*", "+", "-"] do
    case s do
      "*" -> %Forth{ ev | stack: [ a * b | t ]}
      "-" -> %Forth{ ev | stack: [ b - a | t ]}
      "+" -> %Forth{ ev | stack: [ a + b | t ]}
      "/" ->
        if a == 0 do
          raise Forth.DivisionByZero
        else
          %Forth{ ev | stack: [ div(b, a) | t ]}
        end
      _ -> ev
    end
  end

  defp evaluate(%Forth{stack: []}, "dup"), do: raise StackUnderflow
  defp evaluate(ev=%Forth{stack: [ v | t ]}, "dup") do
    %Forth{ ev | stack: [ v, v | t ] }
  end

  defp evaluate(%Forth{stack: []}, "drop"), do: raise StackUnderflow
  defp evaluate(ev=%Forth{stack: [ _ | t ]}, "drop") do
    %Forth{ ev | stack: t }
  end

  defp evaluate(%Forth{stack: s}, "swap") when length(s) < 2, do: raise StackUnderflow
  defp evaluate(ev=%Forth{stack: [ a, b | t ]}, "swap") do
    %Forth{ ev | stack: [ b, a | t ] }
  end

  defp evaluate(%Forth{stack: s}, "over") when length(s) < 2, do: raise StackUnderflow
  defp evaluate(ev=%Forth{stack: stack=[ _, a | _ ]}, "over") do
    %Forth{ ev | stack: [ a | stack ] }
  end

  defp evaluate(ev=%Forth{stack: stack, dict: dict}, exp) do
    if Regex.match?(~r/^\d+$/, exp) do
      %Forth{ ev | stack: [ String.to_integer(exp) | stack ]}
    else
      eval(ev, Map.get(dict, exp) || raise UnknownWord)
    end
  end
end
