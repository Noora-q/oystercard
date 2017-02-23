require 'oystercard'
require 'journey'

describe Oystercard do


let(:entry_station){ double :station}
let(:exit_station){ double :station}
# let(:journey){{ entry_station: entry_station, exit_station: exit_station }}


describe '#balance' do
  it 'checks that a new card has a balance' do
    expect(subject.balance).to be_a Float
  end
end

describe '#top_up' do

  it 'tops up' do
    expect{ subject.top_up 1}.to change{ subject.balance }.by 1
  end

  it 'checks that balance cannot go above limit' do
    limit = Oystercard::MAXIMUM_BALANCE
    subject.top_up limit
    expect{subject.top_up 1}.to raise_error "card balance cannot go above #{limit}"
  end
end

describe '#minimum amount' do
  it ' checks that balance cannot go below limit' do
    subject.top_up 0.5
    expect { subject.touch_in }.to raise_error "card balance is below minimum fare"
  end
end

describe '#touch_out' do

  it 'deducts minimum fare at end of journey' do
    subject.top_up(50)
    subject.touch_in
    expect{ subject.touch_out }.to change{subject.balance}.by -1#Oystercard::MINIMUM_FARE
  end

  it 'records exit station' do
      journey= Journey.new("Euston","Hampstead")
      subject.top_up(20)
      # subject.touch_in(entry_station)
      # subject.touch_out(exit_station)
      expect(journey.exit_station).to eq "Hampstead"
  end

  it 'checks that the card history has an empty list of journeys' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include(entry_station => exit_station)
  end
end

end
