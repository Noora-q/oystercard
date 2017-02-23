class Journey

attr_accessor :entry_station, :exit_station

MINIMUM_FARE = 1.0
PENALTY_FARE = 6.0

def initialize(entry_station = nil, exit_station = nil)
  @entry_station = entry_station
  @exit_station = exit_station
end

def in_journey?
  !!self.entry_station
end

def fare_checker
  if self.exit_station == nil || self.entry_station == nil
    PENALTY_FARE
    puts "penalty deducted"
  else
    MINIMUM_FARE
  end
end

def start(entry)
  @entry_station = entry
end

def finish(departure)
  @exit_station = departure
end



end
