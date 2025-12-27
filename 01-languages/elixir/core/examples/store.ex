defmodule Store do
   def calculate_price(price, client_type \\ :new)

   def calculate_price(price, :new) when is_number(price) and price >= 100 do
      discount = price * 0.1
      final_price = price - discount
      {:ok, discount, final_price}
      ## IO.puts("Discount: #{Float.round(discount, 2)}, the final price is: #{Float.round(final_price, 2)}")
   end

   def calculate_price(price, :vip) when is_number(price) do
      discount = price * 0.2
      final_price = price - discount
      {:ok, discount, final_price}
      ## IO.puts("Discount: #{Float.round(discount, 2)}, the final price is: #{Float.round(final_price, 2)}")
   end

   def calculate_price(price, client_type) when is_number(price) and is_atom(client_type) do
      {:ok, 0, price}
      ## IO.puts("Discount: #{Float.round(discount, 2)}, the final price is: #{Float.round(final_price, 2)}")
   end
end

# price = 120
# type = :new

# {:ok, discount, final_price} = Store.calculate_price(price, type)

# IO.puts("Discount: #{Float.round(discount, 2)}, the final price is: #{Float.round(final_price, 2)}")
