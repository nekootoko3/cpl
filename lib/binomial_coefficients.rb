class BinomialCoefficients
  attr_reader :mod
  attr_accessor :fac, :finv, :inv

  def initialize(max, mod)
    @mod  = mod
    @fac  = Array.new(max)
    @finv = Array.new(max)
    @inv  = Array.new(max)

    fac[0]  = fac[1] = 1
    finv[0] = finv[1] = 1
    inv[1]  = 1
    2.upto(max-1) do |i|
      fac[i]  = fac[i - 1] * i % mod
      inv[i]  = mod - inv[mod % i] * (mod / i) % mod
      finv[i] = finv[i - 1] * inv[i] % mod
    end
  end

  def compute(n, k)
    return 0 if n < k
    return 0 if n < 0 || k < 0

    fac[n] * (finv[k] * finv[n - k] % mod) % mod
  end
end
