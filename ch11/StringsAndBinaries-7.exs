# Exercise: StringsAndBinaries-7
# Chapter 11, Page 131

# From Chapter 10 exercise...
defmodule Exercise do
  # Compute the sales tax for an order.
  def compute_sales_tax(order, tax_rates) do
    if sales_tax = Keyword.get(tax_rates, order[:ship_to]) do
      sales_tax
    else
      0
    end
  end

  # Base Case: An empty list.
  def compute_total([], _), do: []

  # Recursive Case: Compute the total of the current total.
  def compute_total([ current_order | remaining_orders ], tax_rates) do
    net = current_order[:net_amount]
    total_amount = net + net * compute_sales_tax(current_order, tax_rates)
    processed_order = [Keyword.put(current_order, :total_amount, total_amount)]
    processed_order ++ compute_total(remaining_orders, tax_rates)
  end
end

# There is no tax applied to the order if a
# shipment is not to NC or TX.
tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = Stream.resource(
  # start_fun
  fn -> File.open!("StringsAndBinaries-7.csv") end,
  # next_fun
  fn file ->
    case IO.read(file, :line) do
      data when is_binary(data) -> {[data], file}
      _ -> {:halt, file}
    end
  end,
  # after_fun
  fn file -> File.close(file) end
)

Enum.to_list(orders)
|> tl
|> Enum.map(&String.trim_trailing/1)
|> Enum.map(fn s -> String.split(s, ",") end)
|> Enum.map(fn [ id, ship_to, net_amount ] -> [
     id: String.to_integer(id),
     ship_to: ship_to |> String.trim(":") |> String.to_atom,
     net_amount: String.to_float(net_amount)
   ] end)
|> Exercise.compute_total(tax_rates)
|> IO.inspect
