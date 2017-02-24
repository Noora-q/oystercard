require 'journeylog'
require 'journey'

describe Journeylog do
let(:journey_class) { Journey.new }
subject(:log) {described_class.new(journey_class)}

describe "Journey list" do
  context "has the array of journey's been created?" do
    it 'checks that the card history has an empty list of journeys' do
      expect(subject.journeys).to be_empty
    end
  end

  context "testing that start initializes a journey with an entry station" do
    it 'records entry station' do
      expect(log.start("Hampstead")).to eq journey_class.entry_station
    end
  end


end
#
#   it 'stores a journey' do
#     subject.touch_in(entry_station)
#     subject.touch_out(exit_station)
#     expect(subject.journeys).to include(entry_station => exit_station)
#   end
# end
end
