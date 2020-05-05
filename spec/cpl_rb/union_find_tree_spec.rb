require "spec_helper"

RSpec.describe UnionFindTree do
  it { expect(UnionFindTree.new(3)).to be_a(UnionFindTree) }

  it "work expectedly as union find tree" do
    utf = UnionFindTree.new(8)
    utf.unite(1, 2)
    utf.unite(3, 2)
    expect(utf.same(1, 3)).to be_truthy
    expect(utf.same(1, 4)).to be_falsey
    utf.unite(2, 4)
    expect(utf.same(4, 1)).to be_truthy
    utf.unite(4, 2)
    utf.unite(0, 0)
    expect(utf.same(0, 0)).to be_truthy
  end
end
