# Exercise: ListsAndRecursion-8
# Chapter 10, Page 114

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

# Here's a list of orders:
orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount:  50.00 ]
]

# Compute the total amounts.
Exercise.compute_total(orders, tax_rates) |> IO.inspect
