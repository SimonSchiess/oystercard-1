# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  CARD_LIMIT = 90
  MINIMUM_FUNDS = 1
  AMOUNT = 1

  def initialize(balance = 0)
    @balance = 0
    @journey_history = []
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

  def touch_out(tube_station)
    deduct(AMOUNT)
    # is assuming amount does not change
    this_journey = Hash.new
    this_journey[:entry] = @entry_station
    this_journey[:exit] = tube_station
    @journey_history.push(this_journey)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
