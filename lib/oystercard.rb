require_relative 'journey'

class Oystercard

attr_reader :balance, :journeys
#:entry_station, :exit_station, :journeys


MAXIMUM_BALANCE = 90.0
MINIMUM_FARE = 1.0
PENALTY_FARE = 6.0

def initialize(limit = MAXIMUM_BALANCE, floor = MINIMUM_FARE, penalty = PENALTY_FARE)

  @balance = 0.0
  @limit = limit
  @in_journey = false
  @minimum_fare = floor
  @journeys= []
  @journey = Journey.new
  @penalty_fare = penalty

end

def top_up(amount)
  raise "card balance cannot go above #{@limit}" if check_if_new_balance_will_be_above_limit?(amount)
  @balance += amount

end


def check_if_new_balance_will_be_above_limit?(amount)
    (@balance + amount) > @limit
end

def minimum_amount?
  true if @balance < @minimum_fare
end

# def in_journey?
#   @journey.entry_station
# end

def touch_in(entry_station= "Liverpool")
  raise "card balance is below minimum fare" if minimum_amount?
  @journey.entry_station = entry_station
  @in_journey=true
end

def touch_out(exit_station= "Hampstead")
  @journey.exit_station= exit_station
  fare_checker
  @journeys << Hash[@journey.entry_station,@journey.exit_station]
  leaving_the_station

end


private

def fare_checker
  if @journey.exit_station == nil || @journey.entry_station == nil
    deduct(@penalty_fare)
    puts "penalty deducted"
  else
    deduct(@minimum_fare)
  end
end

def leaving_the_station
  @journey.entry_station = nil
  @in_journey = false
end


def deduct(amount)
  @balance -= amount
end


end
