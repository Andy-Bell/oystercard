require 'balance'

describe Balance do
  subject(:balance) { described_class.new}
  
  context 'responses' do
    it { is_expected.to respond_to :current }
    it { is_expected.to respond_to :add }
  end

  describe '#add' do
    it 'adds 10 to the card' do
      expect{ balance.add(10) }.to change{ balance.current }.by(10)
    end

    it 'raises an error when a non valid object is input' do
      expect{ balance.add("foo") }.to raise_error("Invalid input")
    end

    it 'allows money to be added to reach limit' do
      expect{ balance.add(90) }.not_to raise_error
    end

    it 'raises an error when exceeding limit' do
      balance.add(90)
      expect{ balance.add(1) }.to raise_error("Exceeded limit")
    end
  end

  describe '#deduct' do
    before do 
      balance.add(10)
    end

    it 'deducts 5 from the balance' do
      expect{ balance.deduct(5) }.to change{ balance.current }.by(-5) 
    end

    it 'raises an error when a non valid object is input' do 
      expect{ balance.deduct("foo") }.to raise_error("Invalid input")
    end

    it "raises an error when balance.current would go below zero" do
      expect{ balance.deduct(11) }.to raise_error("Insufficient funds")
    end
  end

  describe ':current' do
    it 'initializes a balance of zero' do
      expect(balance.current).to eq(0)
    end
  end

end
