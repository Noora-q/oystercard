class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journeys

MAXIMUM_BALANCE = 90.0
MINIMUM_FARE = 1.0

def initialize(limit = MAXIMUM_BALANCE, floor = MINIMUM_FARE)

  @balance = 0.0
  @limit = limit
  @in_journey = false
  @minimum_fare = floor
  @entry_station = ""
  @exit_station = ""
  @journeys= []

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

def in_journey?
  !!entry_station
end

def touch_in(entry_station = "Liverpool")
  raise "card balance is below minimum fare" if minimum_amount?
  @in_journey = true
  @entry_station = entry_station
end

def touch_out(exit_station = "Euston")

  deduct(@minimum_fare)
  @exit_station= exit_station
  @journeys << Hash[@entry_station,@exit_station]
  @entry_station = nil
  @in_journey = false
end


private

def deduct(amount)
  @balance -= amount
end


end
