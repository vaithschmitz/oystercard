class Oystercard
attr_reader :balance, :entry_station

MAX_BALANCE = 90
MIN_FARE = 1

def initialize
  @balance = 0
end

def top_up(amount)
	raise "Not A Valid Amount." if invalid_amount?(amount)
  raise "Exceeding maximum balance (#{MAX_BALANCE})." if (@balance + amount) > MAX_BALANCE
	@balance += amount
end

def touch_in(station = "default station")
  raise "Balance Not High Enough For Current Journey." if @balance < MIN_FARE
  @entry_station = station
  in_journey?
end

def touch_out
  deduct()
  @entry_station = nil
  in_journey?
end

def in_journey?
  @entry_station == nil ? false : true 
end

private
  def deduct(amount = MIN_FARE)
    raise "Not A Valid Amount." if invalid_amount?(amount)
    @balance -= amount
  end

  def invalid_amount?(amount)
    !amount.is_a?(Numeric) || amount.negative? || amount == 0
  end
end


