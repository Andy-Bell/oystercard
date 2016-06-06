require './lib/oystercard'
require './lib/station'
require './lib/journey'
require './lib/balance'

card = Oystercard.new
bank = Station.new("Bank",1)
uxbridge = Station.new("Uxbridge",6)
