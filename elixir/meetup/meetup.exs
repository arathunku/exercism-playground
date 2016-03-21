defmodule Meetup do
  @day_of_the_week_to_number %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }
  @symbol_number_to_number %{
    :first => 0,
    :second => 1,
    :third => 2,
    :fourth => 3,
    :last => -1
  }
  @moduledoc """
  Calculate meetup dates.
  """

  def meetup(year, month, weekday, :teenth) do
    day = Enum.find(13..19, fn (day) ->
      :calendar.day_of_the_week(year, month, day) ==  weekday_to_day_of_the_week(weekday)
    end)

    { year, month, day }
  end

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    days = (0..31)
    |> Enum.filter(&(:calendar.valid_date(year, month, &1)))
    |> Enum.filter(fn (day) ->
      :calendar.day_of_the_week(year, month, day) ==  weekday_to_day_of_the_week(weekday)
    end)

    { year, month, Enum.fetch!(days, schedule_to_number(schedule)) }
  end

  defp schedule_to_number(schedule) do
    Map.get(@symbol_number_to_number, schedule)
  end

  defp weekday_to_day_of_the_week(weekday) do
    Map.get(@day_of_the_week_to_number, weekday)
  end
end
