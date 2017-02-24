require_relative 'journey'#

class Oystercard

MAXIMUM_BALANCE = 90.0
attr_reader :balance, :journeys

  def initialize(balance = 0.0)
    @balance = balance
    @journeys= []
    @journey = Journey.new #
    @journeylog = Journeylog.new
    @min_fare = Journey::MINIMUM_FARE
  end

  def top_up(amount)
    message = "card balance cannot go above #{MAXIMUM_BALANCE}"
    raise message if @balance == MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    mesg_1 = "Cannot touch in twice"
    raise mesg_1 if @journey.in_journey? # Swap if condition for @journeylog.current_journey
    mesg_2 = "card balance is below minimum fare"
    raise mesg_2 if balance < @min_fare
    # @journeylog.start(entry_station) # Won't work until fare value and current_journey have been
    # set up in journeylog
    @journey.start(entry_station) # Needs to be removed later
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct
    # @journeys << Hash[@journey.entry_station,@journey.exit_station] # Give this functionality to journeylog
    @journey.entry_station = nil
  end


  private

  def deduct
    @balance -= @journey.fare_checker
  end
end
