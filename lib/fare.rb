# calculates the fare

module Fare

	def self.calculate(entry_station,exit_station)
		
		start = entry_station.zone
		finish = exit_station.zone

		return (finish - start) + 1 if start < finish
		(start - finish) + 1

	end
end