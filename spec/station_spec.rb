require 'station'

describe Station do
  subject(:station) {described_class.new("Euston", 1)}

  it 'knows its name' do
      expect(subject.name).to eq("Euston")
  end

  it 'knows is zone' do
    expect(subject.zone).to eq(1)
  end

end
