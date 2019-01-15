require 'oystercard'

describe Oystercard do
  context "@balance" do
    it "checks if card has balance" do
      expect(subject.instance_variable_get(:@balance)).to eq 0
    end
  end

  context "#top_up" do
  	it "can add to balance" do
      subject.instance_variable_set(:@balance, 3)
  		subject.top_up(2)
  		expect(subject.balance).to eq 5
  	end
    it "throws error if invalid amount" do
      expect{subject.top_up(-1)}.to raise_error("Not A Valid Amount.")
      expect{subject.top_up("string")}.to raise_error("Not A Valid Amount.")
    end
    it "throws error if topped up past max balance (£90)" do
      subject.instance_variable_set(:@balance,85)
      expect { subject.top_up(6) }.to raise_error("Exceeding maximum balance (#{Oystercard::MAX_BALANCE}).")
    end
  end

  context "#deduct" do
  	it "deducts amount from balance" do
  		subject.instance_variable_set(:@balance, 5)
  		subject.deduct(3)
  		expect(subject.balance).to eq 2
  	end
  	it "throws error if invalid amount" do
      expect{subject.deduct(-1)}.to raise_error("Not A Valid Amount.")
      expect{subject.deduct("string")}.to raise_error("Not A Valid Amount.")
  	end

  context "#touch_in" do
    it "throws error if balance is lower than minimum fare" do
      expect{subject.touch_in}.to raise_error("Balance Not High Enough For Current Journey.")
    end
    it "can touch in and begin journey if balance higher than min fare" do
      subject.instance_variable_set(:@balance, 5)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end

  context "#touch_out" do
    it " can touch out and end journey" do
      subject.instance_variable_set(:@card_in_use, true)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

  end
  context "#in_journey" do
    it { is_expected.to respond_to(:in_journey?) }
  end
  end

end
