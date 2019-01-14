class Oystercard
attr_reader :balance

def initialize
  @balance = 1
end

def top_up(amount)
	@balance += amount
end

end
