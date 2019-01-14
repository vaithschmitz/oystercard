class Oystercard
attr_reader :balance

def initialize
  @balance = 1
end

def top_up(amount)
	raise "Not A Valid Amount." if amount.negative || !amount.is_a? Numeric || amount == 0
	@balance += amount
end

end
