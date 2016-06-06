require 'oystercard'
require 'journey'

describe Oystercard do
  subject(:card) { described_class.new(journey) } 

  let(:spy_card) { described_class.new(journey_spy)}
  let(:station1) { double(:station1, :data => {:monument => 1}) }
  let(:station2) { double(:station2, :data => {:aldgate_east => 2}) }
  let(:journey) { double(:journey, :entry_station => station1, :start => true, :finish => true, :fresh => true, :fare => 1) }
  let(:journey_spy) { spy(:journey_spy, :in_journey => false, :fare => 1) }

  context 'responses' do
    it { is_expected.to respond_to :balance }
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it { is_expected.to respond_to(:entry_station) } 
 
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

    it 'calls start on the journey object' do
      spy_card.top_up(5)
      spy_card.touch_in(station1)
      expect(journey_spy).to have_received(:start)
    end

    it "raises an error if balance is insufficient" do
      blank_card = Oystercard.new
      expect{ blank_card.touch_in(station1) }.to raise_error("Insufficient funds")
    end
  end

  context '#touch_out' do
    before(:each) do
      card.top_up(5)
      card.touch_in(station1)
    end
    
    it 'calls end on the journey object' do
      spy_card.top_up(5)
      spy_card.touch_in(station1)
      spy_card.touch_out(station2)
      expect(journey_spy).to have_received(:finish)
    end

    it "deducts 1 from balance" do
      expect{ card.touch_out(station2) }.to change{ card.balance }.by(-1)
    end

    it "sets entry station to nil" do
      spy_card.top_up(5)
      spy_card.touch_in(station1)
      spy_card.touch_out(station2)
      expect(journey_spy).to have_received(:fresh)
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

    context "journey generation" do
      before(:each) do
        card.touch_in(station1)
        card.touch_out(station2)
      end

    #   it 'generates a journey' do
    #     expect(card.journeys).to eq({station1.data => station2.data})
    #   end

    #   it 'generates multiple journeys' do
    #     3.times do
    #       card.touch_in(station1)
    #       card.touch_out(station2)
    #     end
    #     expect(card.journeys).to eq({station1.data => station2.data, station1.data => station2.data,
    #                                  station1.data=> station2.data, station1.data => station2.data})
    #   end
     end
  end

end
