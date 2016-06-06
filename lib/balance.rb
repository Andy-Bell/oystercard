# understands the balance on the card

class Balance

  attr_reader :current

  def initialize
    @current = MIN_BALANCE
  end 

  def add(value)
    add_error(value)
    @current += value
  end

  def deduct(value)
    deduct_error(value)
    @current -= value
  end

    private

    MIN_BALANCE = 0
    MAX_BALANCE = 90

    def add_error(value)
      fail "Invalid input" unless is_number?(value)
      fail "Exceeded limit" if exceeded_limit?(value)
    end

    def deduct_error(value)
      fail "Invalid input" unless is_number?(value)
      fail "Insufficient funds" if below_limit?(value)
    end

    def is_number?(value)
      value.respond_to?(:even?)
    end

    def exceeded_limit?(value)
      current + value > MAX_BALANCE
    end

    def below_limit?(value)
      current - value < MIN_BALANCE
    end
end
