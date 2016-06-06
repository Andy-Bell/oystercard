
class Oystercard
  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = DEFAULT_MIN
    @journeys = {}
  end
  
  def top_up(value)
    top_up_fail(value)
    @balance += value
  end
  
  def touch_in(entry)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = entry
    in_journey?
  end

  def touch_out(exit)
    deduct(MINIMUM_FARE)
    journeys[@entry_station.data] = exit.data
    @entry_station = nil
    in_journey?
  end

  private

  DEFAULT_LIMIT = 90
  DEFAULT_MIN = 0
  MINIMUM_FARE = 1

  def top_up_fail(value)
    fail 'Please input an integer' unless is_number?(value)
    fail 'Exceeded limit' if limit?(value)
  end

  def deduct(value)
    deduct_fail(value)
    @balance -= value
  end
  
  def deduct_fail(value)
    fail "Please input an integer" unless is_number?(value)
    fail "Insufficient funds" if empty?(value)
  end

  def empty?(value)
    (@balance - value) < DEFAULT_MIN
  end

  def limit?(value)
    (@balance + value ) > DEFAULT_LIMIT
  end

  def is_number?(value)
    value.is_a? Integer
  end

  def in_journey?
    return true if entry_station
    false
  end
end
