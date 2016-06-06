# constructs stations objects with a name and zone

class Station

	attr_reader :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def data
    {@name => @zone}
  end

end
