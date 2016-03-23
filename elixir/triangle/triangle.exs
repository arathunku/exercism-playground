defmodule Triangle do
  @positive_length_error { :error, "all side lengths must be positive" }
  @invalid_triangle_error { :error, "side lengths violate triangle inequality" }
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    sides = Enum.sort([a, b, c])
    hypotenuse = List.last(sides)
    cathetus = Enum.slice(sides, 0..1)

    cond do
      hd(sides) <= 0 -> @positive_length_error
      Enum.sum(cathetus) <= hypotenuse -> @invalid_triangle_error
      a == b && a == c -> { :ok, :equilateral }
      length(Enum.uniq(sides)) == 2 -> { :ok, :isosceles }
      true -> { :ok , :scalene }
    end
  end
end
