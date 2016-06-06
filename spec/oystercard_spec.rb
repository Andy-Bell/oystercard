require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new } 

  let(:station1) { double(:station1, :data => {:monument => 1}) }
  let(:station2) { double(:station2, :data => {:aldgate_east => 2}) }

  context 'responses' do
    it { is_expected.to respond_to :balance }
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it { is_expected.to respond_to(:entry_station) } 
    it { is_expected.to respond_to(:journeys) }
  end

  context '#top_up' do
    it 'adds 10 to the card' do
      expect(card.top_up(10)).to eq 10
    end

    it 'adds 5 to the card' do
      expect(card.top_up(5)).to eq 5
    end

    it 'adds 5 to a card with 10 already' do
      card.top_up(10)
      expect(card.top_up(5)).to eq 15
    end

    it 'raises an error when a string is input' do
      expect{card.top_up("foo")}.to raise_error("Please input an integer")
    end

    it 'allows money to be added to reach limit' do
      expect{card.top_up(90)}.not_to raise_error
    end

    it 'raises an error when exceeding limit of 90' do
      card.top_up(90)
      expect{card.top_up(1)}.to raise_error("Exceeded limit")
    end
  end

  context '#touch_in' do
    before(:each) do
      card.top_up(5)
    end

    it "sets in_journey? to true" do
      expect(card.touch_in(station1)).to eq true
    end

    it "raises an error if balance is insufficient" do
      blank_card = Oystercard.new
      expect{ blank_card.touch_in(station1) }.to raise_error("Insufficient funds")
    end

    it "sets entry station" do
      card.touch_in(station1)
      expect(card.entry_station).to eq station1
    end
  end

  context '#touch_out' do
    before(:each) do
      card.top_up(5)
      card.touch_in(station1)
    end

    it "sets in_journey? to false" do
      expect(card.touch_out(station2)).to eq false
    end

    it "deducts 1 from balance" do
      expect{ card.touch_out(station2) }.to change{ card.balance }.by(-1)
    end

    it "sets entry station to nil" do
      card.touch_out(station2)
      expect(card.entry_station).to eq nil
    end	
  end

  context ':balance' do
    it "has a balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  context ':journeys' do
    before(:each) do
      card.top_up(5)
    end

    it 'generates an empty hash' do
      expect(card.journeys).to be_a(Hash)
    end
    context "journey generation" do
      before(:each) do
        card.touch_in(station1)
        card.touch_out(station2)
      end

      it 'generates a journey' do
        expect(card.journeys).to eq({station1.data => station2.data})
      end

      it 'generates multiple journeys' do
        3.times do
          card.touch_in(station1)
          card.touch_out(station2)
        end
        expect(card.journeys).to eq({station1.data => station2.data, station1.data => station2.data,
                                     station1.data=> station2.data, station1.data => station2.data})
      end
    end
  end
end
