# @param num [Integer]
# @return Integer
def divisors(num)
  (1..Math.sqrt(num).floor).map do |divisor|
    next unless num % divisor == 0

    quotient = num / divisor
    quotient == divisor ? [divisor] : [divisor, quotient]
  end.compact.flatten.sort
end
