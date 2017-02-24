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

    context "passing entry and exit stations to journey class" do
      it 'records entry station' do
        expect(log.start("Hampstead")).to eq journey_class.entry_station
      end

      it 'adds exit station and records journey in journeys hash' do
        log.start("Hampstead")
        log.finish("Euston")
        expect(log.journeys).to eq [{ journey_class.entry_station => journey_class.exit_station }]
      end
    end
  end
end
