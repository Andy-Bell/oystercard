class Journey
  attr_reader :entry_station, :end_station, :in_journey, :all_journeys

  MINIMUM_FARE = 1

  def initialize
    @entry_station
    @end_station
    @in_journey = false
    @all_journeys = {}
  end

  def start(station)
    @entry_station= station
    @in_journey= true
  end

  def finish(station)
    @end_station = station
    @all_journeys[entry_station] = end_station
    @in_journey = false
  end

  def fare
    @fare = MINIMUM_FARE
  end

  def fresh
    @entry_station= nil
    @end_station= nil
  end

end
