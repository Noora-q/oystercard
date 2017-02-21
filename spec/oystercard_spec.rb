require 'oystercard'

describe Oystercard do

let(:station){ double :station}

describe '#balance' do
  it 'checks that a new card has a balance' do
    expect(subject.balance).to be_a Float
  end
end

describe '#top_up' do

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'tops up' do
    expect{ subject.top_up 1}.to change{ subject.balance }.by 1
  end

  it 'checks that balance cannot go above limit' do
    limit = Oystercard::MAXIMUM_BALANCE
    subject.top_up limit
    expect{subject.top_up 1}.to raise_error "card balance cannot go above #{limit}"
  end
end

# describe '#deduct' do
#
#   it { is_expected.to respond_to(:deduct).with(1).argument }
#
#   it 'deducts the fare from the cards balance' do
#     subject.top_up 10
#     expect{ subject.deduct 5 }.to change{ subject.balance }.by -5
#   end
# end

describe '#minimum amount' do
  it ' checks that balance cannot go below limit' do
    subject.top_up 0.5
    expect { subject.touch_in }.to raise_error "card balance is below minimum fare"
  end
end

describe '#in_journey?' do
  it 'signals that the card is being used in a journey' do
    subject.top_up(50)
    subject.touch_in
    expect(subject.in_journey?).to be true
  end

  it 'signals that the card is not being used in a journey' do
    subject.top_up(50)
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end

describe '#touch_out' do
  it 'deducts minimum fare at end of journey' do
    subject.top_up(50)
    subject.touch_in
    expect{ subject.touch_out }.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
  end
end

describe '#touch_in' do
  it 'records entry station' do
      # subject.top_up(20)
      # expect(subject.touch_in(station)).to eq(subject.entry_station)
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
  end
end

end

end
