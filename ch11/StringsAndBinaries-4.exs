# Exercise: StringsAndBinaries-4
# Chapter 11, Page 123

defmodule Parse do
  # Utility module defined in Page 122.
  # I think that I should be allowed to use this.

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str),           do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value * 10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end

end

defmodule Panda do # 🐼
  # Dunno why... just felt like using animals for module names.

  defp _split([], delimiter, part, parts) do
    case part do
      [] -> parts
      _  -> parts ++ [part]
    end
  end

  defp _split([ delimiter | tail ], delimiter, part, parts) do
    case part do
      [] -> _split(tail, delimiter, [], parts)
      _  -> _split(tail, delimiter, [], parts ++ [part])
    end
  end

  defp _split([ head | tail ], delimiter, part, parts) do
    _split(tail, delimiter, part ++ [head], parts)
  end

  # Use _split/2. _split/4 is implementation detail.
  defp _split(expr, delimiter) do
    _split(expr, delimiter, [], [])
  end

  def calculate(expr) do
    [operand_1, operator, operand_2] = _split(expr, ?\s)
    case operator do
      '+' -> Parse.number(operand_1) + Parse.number(operand_2)
      '-' -> Parse.number(operand_1) - Parse.number(operand_2)
      '*' -> Parse.number(operand_1) * Parse.number(operand_2)
      '/' -> Parse.number(operand_1) / Parse.number(operand_2)
    end
  end
end

# Test Cases.
IO.inspect Panda.calculate('1 + 1')
IO.inspect Panda.calculate('7 - 4')
IO.inspect Panda.calculate('8 * 8')
IO.inspect Panda.calculate('12 / 3')

# What about repeated whitespace? l33t.
IO.inspect Panda.calculate('   1337   /    7    ')

# Parse.number/1 will handle unary negation.
IO.inspect Panda.calculate('-100 + 50')
