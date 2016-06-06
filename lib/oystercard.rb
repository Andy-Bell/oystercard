# controller class / interface for the human

require_relative 'journey'

class Oystercard
  attr_reader :entry_station, :journey

  def initialize(journey= Journey.new)
    @journey = journey
    @balance = journey.balance
  end

  def top_up(value)
    balance.add(value)
  end
  
  def touch_in(entry)
    journey.start(entry)
  end

  def touch_out(finish)
    journey.finish(finish)
  end

  def current_balance
    balance.current
  end

  def journey_log
    journey.all_journeys.all
  end

    private

    attr_reader :balance

end
