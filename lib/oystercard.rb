require_relative 'journey'

class Oystercard

MAXIMUM_BALANCE = 90.0
attr_reader :balance, :journeys

  def initialize(balance = 0.0)
    @balance = balance
    @journeys= []
    @journey = Journey.new
    @min_fare = Journey::MINIMUM_FARE
  end

  def top_up(amount)
    message = "card balance cannot go above #{MAXIMUM_BALANCE}"
    raise message if @balance == MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station= "Liverpool")
    raise "card balance is below minimum fare" if balance < @min_fare
    @journey.start(entry_station)
  end

  def touch_out(exit_station= "Hampstead")
    @journey.finish(exit_station)
    deduct
    @journeys << Hash[@journey.entry_station,@journey.exit_station]
    leaving_the_station
  end


  private

  def leaving_the_station
    @journey.entry_station = nil
    @in_journey = false
  end


  def deduct
    @balance -= @journey.fare_checker
  end
end
