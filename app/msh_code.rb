class MSHCode

    def self.encode(k,m)
        s1_bits = k.p2.bit_length
        s2_bits = k.p3.bit_length
        s1 = Tools.random_number(s1_bits)
        s2 = Tools.random_number(s2_bits)
        alpha = HenselCode.multiple_decode([k.p1,k.p2,k.p3],k.r1,[m,s1,s2])
        beta = HenselCode.encode(k.p4,k.r2,alpha)

        beta
    end

    def self.decode(k,c)
        alpha = HenselCode.decode(k.p4,k.r2,c)
        m = HenselCode.encode(k.p1,k.r1,alpha)
    end

    def self.add(g,c1,c2)
      c3_ = (c1 + c2)
      c3 = (c1 + c2) % g

      c3
    end

    def self.sub(g,c1,c2)
      (c1 - c2) % g
    end

    def self.mul(g,c1,c2)
      (c1 * c2) % g
    end
end
