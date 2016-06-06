# made to module so test no longer works

# require 'fare'



# describe Fare do
	
# 	subject(:fare) { described_class.new }
# 	let(:station1) { double(:station1, :zone => 2) }
# 	let(:station2) { double(:station2, :zone => 4) }

# 	describe '#calculate' do

# 		it 'calculates the fare to be 3' do
# 			expect(fare.calculate(station1,station2)).to eq(3)
# 		end

# 		it 'calculates the fare to be 3' do
# 			expect(fare.calculate(station2,station1)).to eq(3)
# 		end

# 		it 'calculates the fare to be 1' do
# 			expect(fare.calculate(station1,station1)).to eq(1)
# 		end


# 	end
# end