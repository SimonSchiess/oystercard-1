# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station
  CARD_LIMIT = 90
  MINIMUM_FUNDS = 1
  AMOUNT = 1

  def initialize(balance = 0)
    @balance = 0
  end

  def top_up(amount)
    raise 'Over limit' if @balance + amount > CARD_LIMIT
    @balance = amount
  end

  def touch_in(tube_station)
    raise "insufficient balance" if @balance < MINIMUM_FUNDS
    @entry_station = tube_station
  end

  def journey_in?
    if @entry_station == nil
      false
    else
      true
    end
  end

  def touch_out
    deduct(AMOUNT)
    # is assuming amount does not change
    @entry_station = nil
  end

 

 private

  def deduct(amount)
    @balance -= amount
  end

end



