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
    it "only takes positive numbers" do
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
  end
end
