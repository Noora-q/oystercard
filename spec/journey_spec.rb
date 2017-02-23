
require 'journey'
describe Journey do
subject(:journey) { described_class.new}#(entry_station)}

  describe '#in_journey?' do
    context "should be in journey when passed an entry station" do
      let(:entry_station) { double :station }
      subject(:journey) { described_class.new(entry_station) }
      it 'signals that the card is being used in a journey' do
        expect(subject.in_journey?).to be true
      end
    end

    it 'signals that the card is not being used in a journey' do
      expect(subject.in_journey?).to eq false
    end
  end
  # let(:station) { double :station, zone: 1}
  #
  # it "knows if a journey is not complete" do
  #   expect(subject).not_to be_complete
  # end
  #
  # it 'has a penalty fare by default' do
  #   expect(subject.fare).to eq Journey::PENALTY_FARE
  # end
  #
  # it "returns itself when exiting a journey" do
  #   expect(subject.finish(station)).to eq(subject)
  # end
  #
  # context 'given an entry station' do
  #   subject {described_class.new(entry_station: station)}
  #
  #   it 'has an entry station' do
  #     expect(subject.entry_station).to eq station
  #   end
  #
  #   it "returns a penalty fare if no exit station given" do
  #     expect(subject.fare).to eq Journey::PENALTY_FARE
  #   end
  #
  #   context 'given an exit station' do
  #     let(:other_station) { double :other_station }
  #
  #     before do
  #       subject.finish(other_station)
  #     end
  #
  #     it 'calculates a fare' do
  #       expect(subject.fare).to eq 1
  #     end
  #
  #     it "knows if a journey is complete" do
  #       expect(subject).to be_complete
  #     end
  #   end
  # end
end
