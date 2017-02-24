require_relative 'oystercard'
require_relative 'journey'


class Journeylog

attr_reader :journeys

def initialize(journey_class = Journey.new)
  @journeys = []
  @journey_class = journey_class
end

def start(entry_station)
  @journey_class.start(entry_station)
end

# def finish(exit_station)
#
# end

end
