# Exercise: ControlFlow-2
# Chapter 12, Page 139

# The implementation that uses separate functions with guard clauses
# seems like the best implementation. The `cond` implementation is too
# imperative and not very declarative. The `case` utilizes pattern
# matching as well, but is not as explicit.
#
# [NOTE] (to self): If I ever find myself writing `if... else... done`
# clauses, I might be able to refactor the code by making each logical
# proposition in the conditions an element in a tuple.
#
# Logical OR can be refactored into two different patterns.
# Logical AND can be refactored into a pattern that matches two elements.
