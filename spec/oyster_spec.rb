require 'oystercard'

describe Oystercard do
  context "@balance" do
    it "checks if card has balance" do
      expect(subject.instance_variable_get(:@balance)).to eq 1
    end
  end
  context "#top_up" do
  	it "can add to balance" do
      subject.instance_variable_set(:@balance, 3)
  		subject.top_up(2)
  		expect(subject.balance).to eq 5
  	end
    it "only takes positive numbers" do
      expect{subject.top_up(-1)}.to raise_error
      expect{subject.top_up("string")}.to raise_error
    end
  end
end
