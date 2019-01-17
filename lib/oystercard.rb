class Oystercard
attr_reader :balance, :journey_history

MAX_BALANCE = 90
MIN_FARE = 1

def initialize
  @balance = 0
  @journey_history = []
end

def top_up(amount)
  raise "Not A Valid Amount." if invalid_amount?(amount)
  raise "Exceeding maximum balance (#{MAX_BALANCE})." if (@balance + amount) > MAX_BALANCE
  @balance += amount
end

def touch_in(station = "default station")
  raise "Balance Not High Enough For Current Journey." if @balance < MIN_FARE
  record_journey(station)
  in_journey?
end

def touch_out(station = "default station")
  deduct()
  record_journey(station)
  in_journey?
end

def in_journey?
  @journey_history.length == 1
end

def record_journey(station)
  @journey_history.push(station)
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

card = Oystercard.new
card.top_up(20)
card.touch_in("here")
p card.in_journey?
card.touch_out("there")
p card.in_journey?
p card


