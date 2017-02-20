class Oystercard

attr_reader :balance

MAXIMUM_BALANCE = 90.0
MINIMUM_FARE = 1.0

def initialize(limit = MAXIMUM_BALANCE, floor = MINIMUM_FARE)

  @balance = 0.0
  @limit = limit
  @in_journey = false
  @minimum_fare = floor

end

def top_up(amount)
  raise "card balance cannot go above #{@limit}" if check_if_new_balance_will_be_above_limit?(amount)
  @balance += amount

end

def deduct(amount)
  @balance -= amount
end

def check_if_new_balance_will_be_above_limit?(amount)
    (@balance + amount) > @limit
end

def minimum_amount?
  true if @balance < @minimum_fare
end

def in_journey?
  if @in_journey
    true
  else
    false
  end
end

def touch_in
  raise "card balance is below minimum fare" if minimum_amount?
  @in_journey = true
end

def touch_out
  @in_journey = false
end

end
