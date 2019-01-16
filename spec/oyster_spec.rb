require 'oystercard'

describe Oystercard do

let(:station) {double :station}

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
    it "throws error if topped up past max balance (£90)" do
      subject.instance_variable_set(:@balance,85)
      expect { subject.top_up(6) }.to raise_error("Exceeding maximum balance (#{Oystercard::MAX_BALANCE}).")
    end
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
    it "card remembers entry station" do
      subject.instance_variable_set(:@balance, 30)
      subject.touch_in(station)
      expect(subject.instance_variable_get(:@entry_station)).to eq station
    end
    it "card knows it's in journey after touching in" do 
      subject.instance_variable_set(:@balance, 30)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end
  end

  context "#touch_out" do
    it "can touch out and end journey" do
      subject.instance_variable_set(:@card_in_use, true)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
    it "deducts fare from balance upon touching out" do
      subject.instance_variable_set(:@balance, 20) 
      expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
    end
    it "expect card to forget entry station when touching out" do
      subject.touch_out
      expect(subject.instance_variable_get(:@entry_station)).to eq nil
    end
  end

  context "@journey_history" do
    it "every card starts with an empty journey history" do 
      expect(subject.instance_variable_get(:@journey_history)).to be_empty
    end
    it "creates a journey after touching in and out" do
      subject.instance_variable_set(:@balance, 30)
      subject.touch_in("here")
      subject.touch_out("there")
      expect(subject.instance_variable_get(:@journey_history)).to include("here" => "there")
    end
  end
end

