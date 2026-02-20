defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, numeric_component} = volume_pair
    numeric_component
  end

  def to_milliliter(volume_pair)

  def to_milliliter({:cup, quantity}), do: {:milliliter, quantity * 240}

  def to_milliliter({:fluid_ounce, quantity}), do: {:milliliter, quantity * 30}

  def to_milliliter({:teaspoon, quantity}), do: {:milliliter, quantity * 5}

  def to_milliliter({:tablespoon, quantity}), do: {:milliliter, quantity * 15}

  def to_milliliter({:milliliter, quantity}), do: {:milliliter, quantity}

  def from_milliliter(volume_pair, unit)

  def from_milliliter({_, quantity}, :cup), do: {:cup, quantity / 240}

  def from_milliliter({_, quantity}, :fluid_ounce), do: {:fluid_ounce, quantity / 30}

  def from_milliliter({_, quantity}, :teaspoon), do: {:teaspoon, quantity / 5}

  def from_milliliter({_, quantity}, :tablespoon), do: {:tablespoon, quantity / 15}

  def from_milliliter({_, quantity}, :milliliter), do: {:milliliter, quantity}

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
