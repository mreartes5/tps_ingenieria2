require_relative '../app'
require 'test/unit'

def deny(condition, message="Expected condition to be unsatisfied")
  assert !condition, message
end
