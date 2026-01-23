defmodule Lasagna do
  # Please define the 'expected_minutes_in_oven/0' function
  def expected_minutes_in_oven() do
    40
  end
  # Please define the 'remaining_minutes_in_oven/1' function
  def remaining_minutes_in_oven(current_time) do
    total_time = expected_minutes_in_oven()
    total_time - current_time  
  end
  # Please define the 'preparation_time_in_minutes/1' function
  def preparation_time_in_minutes(layers) do 
    time_takes_layer = 2
    layers * time_takes_layer
  end
  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(total_layers, total_time_in_oven) do
    time_in_layers = preparation_time_in_minutes(total_layers)
    time_in_layers + total_time_in_oven
  end
  # Please define the 'alarm/0' function
  def alarm(), do: "Ding!"
 
end
