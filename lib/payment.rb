# adjusts the balance 

require_relative 'balance'

module Payment

	def self.penalty(balance)
    balance.deduct(PENALTY_FARE)
    fail "Penalty fare has been charged, try again"
  end

  def self.payment(balance, fare)
    balance.deduct(fare)
  end

	  private

	  MINIMUM_FARE = 1
    PENALTY_FARE = 6

end