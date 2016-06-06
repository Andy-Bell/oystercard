# understands the process of journeys

require_relative 'balance'
require_relative 'payment'
require_relative 'log'
require_relative 'fare'

class Journey
  attr_reader :entry_station, :end_station, :in_journey, :all_journeys, :balance

  def initialize(balance = Balance.new, log= Log.new)
    @in_journey = false
    @all_journeys = log
    @balance = balance
  end

  def start(station)
    penalty_start if in_journey
    @entry_station= station
    @in_journey= true
  end

  def finish(station)
    penalty_end unless in_journey
    @end_station = station
    wind_down
  end

    private

    def fresh
      @entry_station= nil
      @end_station= nil
      @in_journey = false
    end

    def fare 
      Fare.calculate(entry_station, end_station)
    end

    def wind_down
      Payment.payment(balance, fare)
      all_journeys.log(entry_station, end_station)
      fresh
    end

    def penalty_start
      @in_journey = false
      Payment.penalty(balance)
    end

    def penalty_end
      @in_journey = true
      Payment.penalty(balance)
    end


end
