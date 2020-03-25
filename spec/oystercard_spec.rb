require './lib/oystercard'

describe Oystercard do
  subject(:card) {Oystercard.new}

  it 'oystercard has a balance of 0' do
    expect(card).to have_attributes(:balance => 0)
  end

  context '#top_up' do
    it 'oystercard responds to method top_up' do
      expect(card).to respond_to(:top_up).with(1).argument
    end
  
    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it '#top_up fails if over balance' do
      expect{ card.top_up(95) }.to raise_error "Over limit"
    end
  end  

=begin
  context '#deduct' do
    it 'oystercard responds to method deduct' do
      expect(card).to respond_to(:deduct).with(1).argument
    end

    it 'can top up the balance' do
      subject.top_up(20)
      expect { subject.deduct(1) }.to change{ subject.balance }.by (-1)
      what about if it goes under 0
    end
  end
=end

  context '#touch_in' do 
    it 'start journey' do
      expect(card).to respond_to(:touch_in)
      #expect(card).to be_journey_in("yes")
      card.top_up(1)
      card.touch_in("Embankment")
      expect(card.journey_in?).to eql true
    end

    it 'will not allow card to touch in  and will throw an error  if have less than one pound in balance' do
      expect {card.touch_in("Embankment")}.to raise_error "insufficient balance"
    end 


    it 'will register the station we are at' do
      subject.top_up(5)
      subject.touch_in('Embankment')
      expect(subject.entry_station).to eq 'Embankment'
    end

    it 'will register the station we are at' do
      subject.top_up(5)
      subject.touch_in('Kings Cross')
      expect(subject.entry_station).to eq 'Kings Cross'
    end
  end

  context '#touch_out' do 
    it 'ends journey' do
    expect(card).to respond_to(:touch_out)
    expect(card).to_not be_journey_in
    end 

    it 'deduct money from balance' do
      expect{card.touch_out}.to change{ subject.balance }.by (-1)
    end 

    #expect { subject.deduct(1) }.to change{ subject.balance }.by (-1)
    # what about if it goes under 0

    it ' entry_station will be nil' do
      subject.top_up(5)
      subject.touch_in("Embankment")
      subject.touch_out
      expect(subject.entry_station).to eql nil
    end
  end

  context '#journey_history' do 

    it 'returns last journey: going from kings cross to embankment' do
      subject.top_up(5)
      subject.touch_in('Kings Cross')
      subject.touch_out('Embankment')
      expect(subject.journey_history).to eq entry: 'Kings Cross', exit: 'Embankment'
    end

  end
end

#Write a test that checks that an error is thrown if 
#a card with insufficient balance is touched in