# Exercise: Functions-4
# Chapter 5, Page 47

prefix = fn pf -> (fn name -> "#{pf} #{name}" end) end
mrs = prefix.("Mrs")
mr = prefix.("Mr")

IO.puts mrs.("Nutty")
IO.puts mr.("Nutty")
IO.puts prefix.("Just").("Married")
