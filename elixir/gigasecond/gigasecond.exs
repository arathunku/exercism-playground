defmodule Gigasecond do
  @gigasecond trunc(:math.pow(10, 9))
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime
	def from(datetime) do
    :calendar.gregorian_seconds_to_datetime(
      :calendar.datetime_to_gregorian_seconds(datetime) + @gigasecond
    )
	end
end
