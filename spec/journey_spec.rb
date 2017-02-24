
require 'journey'
describe Journey do
subject(:journey) { described_class.new}



  describe '#in_journey?' do
    context "should be in journey when passed an entry station" do
      let(:entry_station) { double :station }
      subject(:journey) { described_class.new(entry_station) }
      it 'signals that the card is being used in a journey' do
        expect(journey.in_journey?).to be true
      end
    end

    it 'signals that the card is not being used in a journey' do
      expect(journey.in_journey?).to eq false
    end

    context "set start point for journey" do
      let(:entry) { "Hampstead" }
      let(:departure) { "Euston" }

      it 'records entry station' do
        expect{ journey.start(entry) }.to change{ journey.entry_station }.to eq "Hampstead"
      end

      it "records exit station" do
        expect{ journey.finish(departure) }.to change{ journey.exit_station }.to eq "Euston"
      end
    end
  end
end
