defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.trim(name) |> String.at(0)
  end

  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    # [first, last] = String.split(full_name)
    # i1 = first |> initial()
    # i2 = last |> initial()
    # i1 <> i2
    full_name
    |> String.split()
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    middle = [full_name1, full_name2]
    |> Enum.map(&initials/1)
    |> Enum.join("  +  ")


    """
    ❤-------------------❤
    |  #{middle}  |
    ❤-------------------❤
    """

    # Please implement the pair/2 function
  end
end
