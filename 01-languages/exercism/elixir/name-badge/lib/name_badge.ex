defmodule NameBadge do
  def print(id, name, department)
  def print(nil, name, nil), do: "#{name} - OWNER"
  def print(nil, name, department), do: "#{name} - #{department |> String.upcase()}"
  def print(id, name, nil), do: "[#{id}] - #{name} - OWNER"

  def print(id, name, department) do
    "[#{id}] - #{name} - #{department |> String.upcase()}"
  end

  # Other way to do with if:
  # def print(id, name, department) do
  #   dept = if department == nil, do: "OWNER", else: String.upcase(department)
  #
  #   if id == nil do
  #     "#{name} - #{dept}"
  #   else
  #     "[#{id}] - #{name} - #{dept}"
  #   end
  # end
end
