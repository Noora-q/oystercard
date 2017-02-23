require 'oystercard'
require 'journey'

describe Oystercard do

  let(:balance) { 0 }
  let(:entry_station){ double :station}
  let(:exit_station){ double :station}
  subject(:card) { described_class.new(balance) }
  max = Oystercard::MAXIMUM_BALANCE

  describe '#top_up' do
    it 'tops up' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end

    context "maximum balance error" do
      let(:balance) {max}
      it 'checks that balance cannot go above limit' do
        message = "card balance cannot go above #{max}"
        expect{subject.top_up 1}.to raise_error message
      end
    end
  end

  describe '#minimum amount' do

    it ' checks that balance cannot go below limit' do
      expect { subject.touch_in("Euston") }.to raise_error "card balance is below minimum fare"
    end
  end

  describe '#touch_in' do
    let(:balance) {max}
    it ' raises error on multiple touch-in' do
      expect{ 2.times{card.touch_in("Euston")} }.to raise_error "Cannot touch in twice"
    end
  end

  describe '#touch_out' do
  let(:balance) {max}
    it 'deducts minimum fare at end of journey' do
      subject.touch_in("Euston")
      expect{ subject.touch_out("Hampstead") }.to change{subject.balance}.by -1#Oystercard::MINIMUM_FARE
    end

    it 'checks that the card history has an empty list of journeys' do
      expect(subject.journeys).to be_empty
    end

    it 'stores a journey' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(entry_station => exit_station)
    end
  end
end
