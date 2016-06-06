require 'oystercard'
require 'journey'

describe Oystercard do
  subject(:card) { described_class.new(journey) } 

  let(:spy_card) { described_class.new(journey_spy)}
  let(:station1) { double(:station1, :data => {:monument => 1}) }
  let(:station2) { double(:station2, :data => {:aldgate_east => 2}) }
  let(:journey) { double(:journey, :start => true, :finish => true, :balance => balance_spy) }
  let(:journey_spy) { spy(:journey_spy, :balance => balance_spy) }
  let(:balance_spy) { spy(:balance_spy, :current => 0) }

  context 'responses' do
    it { is_expected.to respond_to :current_balance }
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it { is_expected.to respond_to(:entry_station) } 
 
  end

  context '#top_up' do
    it 'is able to call balance' do
      spy_card.top_up(10)
      expect(balance_spy).to have_received(:add)
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

  end

  context ':balance' do
    it "has a balance of 0" do
      expect(card.current_balance).to eq 0
    end
  end
end
