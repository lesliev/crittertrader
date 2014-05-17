require 'spec_helper'

describe Critter do
  let(:data) { File.read('db/example_critter.cr') }

  it 'validates with a valid critter' do
    c = Critter.new(data: data)
    expect(c.valid?).to be_true
  end

  it 'prevents too many neurons' do
    data2 = data
    1000.times { data2 += "\nn(i=" }
    c = Critter.new(data: data2)
    expect(c.valid?).to be_false
  end
end
