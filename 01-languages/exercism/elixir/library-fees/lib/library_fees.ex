defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.add(date, 28)
    else
      Date.add(date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime |> NaiveDateTime.to_date() |> Date.diff(planned_return_date) |> max(0)
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() |> Kernel.==(1)

  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    real_return_date = datetime_from_string(return)
    planned_return_date = return_date(checkout_date)
    real_diff = days_late(planned_return_date, real_return_date)

    if monday?(real_return_date) do
      div(real_diff * rate, 2)
    else
      real_diff * rate
    end
  end
end
