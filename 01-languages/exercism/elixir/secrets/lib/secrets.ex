defmodule Secrets do
  import Bitwise
  def secret_add(secret) do
    fn (newValue ) -> newValue + secret  end
  end

  def secret_subtract(secret) do
    fn newValue -> newValue - secret end
  end

  def secret_multiply(secret) do
    fn newValue -> newValue * secret end
  end

  def secret_divide(secret) do
    fn newValue -> div(newValue , secret) end
  end

  def secret_and(secret) do
    fn newValue -> Bitwise.band(secret, newValue) end
  end

  def secret_xor(secret) do
    fn newValue -> Bitwise.bxor(secret, newValue) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn newValue -> secret_function1.(newValue) |> secret_function2.()  end
  end
end
