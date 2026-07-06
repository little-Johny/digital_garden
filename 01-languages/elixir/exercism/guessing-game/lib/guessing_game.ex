defmodule GuessingGame do

  def compare(secret_number , guess \\ :no_guess)
  def compare(_secret_number, :no_guess), do: "Make a guess"

  def compare(s, s) do
    "Correct"
  end

  def compare(secret_number, guess) when secret_number+1 == guess do
    "So close"
  end
  def compare(secret_number, guess) when secret_number-1 == guess do
    "So close"
  end

  def compare(secret_number, guess) when guess > secret_number  do
    "Too high"
  end
  def compare(_secret_number, _guess) , do: "Too low"


end
