require "spec_helper"

RSpec.describe UnionFindTree do
  it { expect(UnionFindTree.new(3)).to be_a(UnionFindTree) }

  it "work expectedly as union find tree" do
    uft = UnionFindTree.new(8)
    uft.unite(1, 2)
    uft.unite(3, 2)
    expect(uft.same(1, 3)).to be_truthy
    expect(uft.same(1, 4)).to be_falsey
    uft.unite(2, 4)
    expect(uft.same(4, 1)).to be_truthy
    uft.unite(4, 2)
    uft.unite(0, 0)
    expect(uft.same(0, 0)).to be_truthy
  end
end
