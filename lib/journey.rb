class Journey

attr_accessor :entry_station, :exit_station

def initialize(entry_station = nil, exit_station = nil)
  @entry_station = entry_station
  @exit_station = exit_station
end

def in_journey?
  !!self.entry_station
end

end