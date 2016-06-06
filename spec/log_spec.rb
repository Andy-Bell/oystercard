require 'log'

describe Log do
  subject(:log) { described_class.new }
  
  let(:station1){ double(:station1) }
  let(:station2){ double(:station2) }
  
  describe ":all journeys" do
    it 'creates an empty all_journeys object' do
      expect(log.all).to respond_to(:each)
    end
  end

  describe '#log' do
    before(:each) do
      log.log(station1,station2)
    end
    it 'generates a journey' do
      expect(log.all).to eq([{station1 => station2}])
    end
    it 'generates multiple journeys' do
      3.times do
        log.log(station1,station2)
      end
      expect(log.all).to eq([{station1 => station2}, {station1 => station2},
                             {station1 => station2}, {station1 => station2}])
    end
  end
end
