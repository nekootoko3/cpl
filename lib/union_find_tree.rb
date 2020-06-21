class UnionFindTree
  attr_accessor :parent, :rank

  def initialize(n)
    @parent = Array.new(n) { |i| i }
    @rank = Array.new(n, 0)
  end

  def unite(x, y)
    root_x = root(x)
    root_y = root(y)
    return if root_x == root_y

    if rank[root_x] < rank[root_y]
      parent[root_x] = root_y
    else
      parent[root_y] = root_x
      rank[root_x] += 1 if rank[root_x] == rank[root_y]
    end
  end

  def same(x, y)
    root(x) == root(y)
  end

  private

  def root(x)
    return x if x == parent[x]

    parent[x] = root(parent[x])
    parent[x]
  end
end
