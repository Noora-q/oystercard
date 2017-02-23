require 'journeylog'

describe Journeylog do

subject(:log) {described_class.new}


describe 'journey log array' do
  it 'holds a log of journeys' do
    expect(log.journeys).to eq []
  end
end





end
