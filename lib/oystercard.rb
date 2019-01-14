class Oystercard
attr_reader :balance

MAX_BALANCE = 90

def initialize
  @balance = 0
  @card_in_use = false
end

def top_up(amount)
	raise "Not A Valid Amount." if invalid_amount?(amount)
  raise "Exceeding maximum balance (#{MAX_BALANCE})." if (@balance + amount) > MAX_BALANCE
	@balance += amount
end

def deduct(amount)
	raise "Not A Valid Amount." if invalid_amount?(amount)
	@balance -= amount
end

def invalid_amount?(amount)
	!amount.is_a?(Numeric) || amount.negative? || amount == 0
end

def touch_in
  @card_in_use = true
end

def touch_out
  @card_in_use = false
end

def in_journey?
  @card_in_use
end

end
