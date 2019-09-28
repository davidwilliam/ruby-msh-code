module X
  class MSHCode

    attr_accessor :lambda, :p1, :p2, :g

    def initialize(lambda)
      @lambda = lambda
      @p1 = X::Tools.random_prime(@lambda)
      @p2 = X::Tools.random_prime(@lambda)
      @g = @p1 * @p2
    end

    def encode(m)
      bit_length = m.bit_length >= 8 ? m.bit_length : 8
      m_prime = X::Tools.random_number(bit_length)

      xp = X::Xp.new [p1,p2], 0, 1
      xp.residue.residues = [m_prime, m]
      alpha = xp.to_r
      beta = X::Xp.new([p2**2], alpha.numerator, alpha.denominator).to_i

      beta
    end

    def decode(beta)
      alpha = X::Xp.new([p2**2], beta.numerator, beta.denominator).to_r
      xp = X::Xp.new [p1,p2], alpha.numerator, alpha.denominator
      m = xp.residue.residues[1]

      m
    end

    def add(beta1,beta2)
      (beta1 + beta2) % g
    end

    def mul(beta1,beta2)
      (beta1 * beta2) % g
    end

  end
end
