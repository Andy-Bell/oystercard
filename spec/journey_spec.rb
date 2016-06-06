require 'journey'

describe Journey do
  subject (:journey) { described_class.new(balance_spy) }
  let(:station1) { double(:station1, :zone => 2) }
  let(:station2) { double(:station2, :zone => 4) }

  let(:balance_spy) { spy(:balance_spy) } 
  let(:log_spy) { spy(:log_spy) }

  describe "#start" do

    it 'sets in_journey to true' do
      expect(journey.start(station1)).to eq true
    end

    it 'sets start station' do
      journey.start(station1)
      expect(journey.entry_station).to eq station1
    end

    it 'charges a penalty fare' do
      journey.start(station1)
      expect{journey.start(station1)}.to raise_error("Penalty fare has been charged, try again")
    end
  end

  describe '#finish' do
  
    before(:each) do 
      journey.start(station1)
    end

    it 'sets the journey to be false' do
      expect(journey.finish(station2)).to eq false
    end

    it 'sets the end station' do
      journey.finish(station2)
      expect(journey.all_journeys.all.last.values.pop).to eq station2
    end
    
    it 'calls deduct on balance' do
      journey.finish(station2)
      expect(balance_spy).to have_received(:deduct)
    end

    context 'penalty fare' do
      before do
        journey.finish(station2)
      end
      
      it 'charges a penalty fare when the user attemts to finish before start is called' do
        expect{ journey.finish(station2) }.to raise_error("Penalty fare has been charged, try again")
      end
    end

    it 'clears entry station' do
      journey.finish(station2)
      expect(journey.entry_station).to eq nil
    end

    it 'clears exit station' do
      journey.finish(station2)
      expect(journey.end_station).to eq nil
    end
  end

  describe ':in_journey' do
    it 'changes state of in_journey' do
      expect(journey.in_journey).to eq false
      journey.start(station1)
      expect(journey.in_journey).to eq true
      journey.finish(station2)
      expect(journey.in_journey).to eq false
    end
  end

  describe ':all_journeys' do
    
    context 'recording journeys' do

      it 'generates a journey' do
        spy_journey = Journey.new(balance_spy, log_spy)
        spy_journey.all_journeys.all
        expect(log_spy).to have_recieved(:all)
      end
      
      it'generates multiple journeys' do
        4.times do
          journey.start(station1)
          journey.finish(station2)
        end
        expect(journey.all_journeys.all).to eq([{station1 => station2},
          {station1 => station2}, {station1 => station2}, {station1 => station2}])
      end
    end
  end
end

