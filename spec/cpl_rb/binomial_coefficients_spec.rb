require "spec_helper"

RSpec.describe BinomialCoefficients do
  let(:max) { 10 ** 6 }
  let(:mod) { 10 ** 9 + 7}
  let!(:bc) { BinomialCoefficients.new(max, mod) }
  it { expect(BinomialCoefficients.new(max, mod)).to be_a(BinomialCoefficients) }

  describe "#compute" do
    it { expect(bc.compute(1, 1)).to eq 1 }
    it { expect(bc.compute(2, 1)).to eq 2 }
    it { expect(bc.compute(5, 2)).to eq 10 }
    it { expect(bc.compute(50, 12)).to eq 121399651100 % mod }
  end
end
