require 'journey'

describe Journey do 
    it 'should give entry station of the journey' do
        j = Journey.new('Kings Cross')
        expect(j.entry_station).to eq ("Kings Cross")
    end

end


