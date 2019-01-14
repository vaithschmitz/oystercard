class Oystercard
attr_reader :balance

MAX_BALANCE = 90

def initialize
  @balance = 0
end

def top_up(amount)
	raise "Not A Valid Amount." if !amount.is_a?(Numeric) || amount.negative? || amount == 0
  raise "Exceeding maximum balance (#{MAX_BALANCE})." if (@balance + amount) > MAX_BALANCE
	@balance += amount
end

def deduct(amount)
	raise "Not A Valid Amount." if !amount.is_a?(Numeric) || amount.negative? || amount == 0
	@balance -= amount
end

end
