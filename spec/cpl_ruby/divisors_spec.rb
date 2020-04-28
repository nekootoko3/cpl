require "spec_helper"

RSpec.describe :divisors do
  it { expect(divisors(0)).to eq [] }
  it { expect(divisors(1)).to eq [1] }
  it { expect(divisors(2)).to eq [1, 2] }
  it { expect(divisors(3)).to eq [1, 3] }
  it { expect(divisors(16)).to eq [1, 2, 4, 8, 16] }
end
