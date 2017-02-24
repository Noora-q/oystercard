require 'oystercard'
require 'journey'

describe Oystercard do

  let(:balance) { 0 }
  let(:entry_station){ double :station}
  let(:exit_station){ double :station}
  subject(:card) { described_class.new(balance) }
  max = Oystercard::MAXIMUM_BALANCE
  min = Journey::MINIMUM_FARE

  describe 'Balance' do
    it '#top_up' do
      expect{ card.top_up(min) }.to change{ card.balance }.by min
    end

    context "maximum balance error" do
      let(:balance) {max}
      it 'checks that balance cannot go above limit' do
        message = "card balance cannot go above #{max}"
        expect{ card.top_up(min) }.to raise_error message
      end
    end

    context 'stops card being used without minimum fare' do
      it 'checks that balance cannot go below minimum fare' do
        message = "card balance is below minimum fare"
        expect { card.touch_in("Euston") }.to raise_error message
      end
    end
  end

  describe 'Touching in and out' do
    context "#touch_in" do
      let(:balance) {max}
      it ' raises error on multiple touch-in' do
        message = "Cannot touch in twice"
        expect{ 2.times{card.touch_in("Euston")} }.to raise_error message
      end
    end

    context '#touch_out' do
    let(:balance) {max}
      it 'deducts minimum fare at end of journey' do
        card.touch_in("Euston")
        expect{ card.touch_out("Hampstead") }.to change{card.balance}.by -min
      end
    end
  end

  # describe "Journey list" do
  #   let(:balance) { max }
  #
  #   it 'stores a journey' do
  #     subject.touch_in(entry_station)
  #     subject.touch_out(exit_station)
  #     expect(subject.journeys).to include(entry_station => exit_station)
  #   end
  # end
end
