require_relative 'oystercard'
require_relative 'journey'


class Journeylog

attr_reader :journeys#, :current_journey

  def initialize(journey_class = Journey.new)
    @journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(entry_station)
    @journey_class.start(entry_station)
    @current_journey = @journey_class.entry_station
  end

  def finish(exit_station)
    @journey_class.finish(exit_station)
    @current_journey = { @journey_class.entry_station => @journey_class.exit_station }
    @journeys << @current_journey
    @current_journey = nil
  end

  private

  def current_journey
    @current_journey || @journey_class = Journey.new
  end

end
