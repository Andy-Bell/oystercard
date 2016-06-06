require 'journey'

describe Journey do
  subject (:journey) { described_class.new }
  let(:station1) { double(:station1, :data => {:monument => 1}) }
  let(:station2) { double(:station2, :data => {:aldgate_east => 2}) }

  describe "#start" do

    it 'sets in_journey to true' do
      expect(journey.start(station1)).to eq true
    end

    it 'sets start station' do
      journey.start(station1)
      expect(journey.entry_station).to eq station1
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
      expect(journey.end_station).to eq station2
    end
  end

  describe '#fare' do
    it 'has a default fare value' do
      expect(journey.fare).to eq 1
    end

    # it 'charges penalty fare' do
    #   journey.finish(station2)
    #   expect(journey.fare).to eq 6
    # end
  end

  describe '#fresh' do
    before(:each) do
      journey.start(station1)
      journey.finish(station2)
    end

    it 'clears entry station' do
      journey.fresh
      expect(journey.entry_station).to eq nil
    end

    it 'clears exit station' do
      journey.fresh
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
    it 'creates an empty all_journeys hash' do
      expect(journey.all_journeys).to be_a(Hash)
    end
    
    context 'recording journeys' do
      before(:each) do
        journey.start(station1)
        journey.finish(station2)
      end

      it 'generates a journey' do
        expect(journey.all_journeys).to eq({station1 => station2})
      end
      
      it'generates multiple journeys' do
        3.times do
          journey.start(station1)
          journey.finish(station2)
        end
        expect(journey.all_journeys).to eq({station1 => station2,
          station1 => station2, station1 => station2, station1 =>station2})
      end
    end
  end
end

