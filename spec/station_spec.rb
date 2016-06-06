require 'station'

describe Station do

	subject(:station) { described_class.new(:name, :zone) }

	context 'data' do

		it "creates a hash" do
			expect(station.data).to be_a(Hash)
		end

		it "creates a hash of name => zone" do
			expect(station.data).to eq({:name => :zone})
		end
	end
end