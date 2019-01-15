class Oystercard
attr_reader :balance

MAX_BALANCE = 90
MIN_FARE = 1

def initialize
  @balance = 0
  @card_in_use = false
end

def top_up(amount)
	raise "Not A Valid Amount." if invalid_amount?(amount)
  raise "Exceeding maximum balance (#{MAX_BALANCE})." if (@balance + amount) > MAX_BALANCE
	@balance += amount
end

def touch_in
  raise "Balance Not High Enough For Current Journey." if @balance < MIN_FARE
  @card_in_use = true
end

def touch_out
  deduct(MIN_FARE)
  @card_in_use = false
end

def in_journey?
  @card_in_use
end

private
  def deduct(amount)
    raise "Not A Valid Amount." if invalid_amount?(amount)
    @balance -= amount
  end

  def invalid_amount?(amount)
    !amount.is_a?(Numeric) || amount.negative? || amount == 0
  end
end


