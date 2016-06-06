class Station

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def data
    {@name => @zone}
  end

end
