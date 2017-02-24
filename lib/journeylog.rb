require_relative 'oystercard'
require_relative 'journey'


class Journeylog

attr_reader :journeys

  def initialize(journey_class = Journey.new)
    @journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(entry_station)
    @journey_class.start(entry_station)
  p  @current_journey = @journey_class.entry_station
  end

  def finish(exit_station)
    @journey_class.finish(exit_station)
  p  @current_journey = { @journey_class.entry_station => @journey_class.exit_station }
  end

  private

  def current_journey
    @current_journey
  end

end
