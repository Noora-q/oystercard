require_relative 'journey'

class Oystercard

attr_reader :balance, :journeys
#:entry_station, :exit_station, :journeys


MAXIMUM_BALANCE = 90.0
# MINIMUM_FARE = 1.0
# PENALTY_FARE = 6.0

def initialize(limit = MAXIMUM_BALANCE)

  @balance = 0.0
  @limit = limit
  @in_journey = false
  @journeys= []
  @journey = Journey.new

end

def top_up(amount)
  raise "card balance cannot go above #{@limit}" if check_if_new_balance_will_be_above_limit?(amount)
  @balance += amount

end


def check_if_new_balance_will_be_above_limit?(amount)
    (@balance + amount) > @limit
end

def minimum_amount?
  true if @balance < Journey::MINIMUM_FARE#
end

# def in_journey?
#   @journey.entry_station
# end

def touch_in(entry_station= "Liverpool")
  raise "card balance is below minimum fare" if minimum_amount?
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
