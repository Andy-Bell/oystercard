class Log
  attr_reader :all
  def initialize
    @all = []
  end

  def log(start, finish)
    @all.push({start => finish})
  end
end
