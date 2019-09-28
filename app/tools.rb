module X
  class Tools

    def self.random_number(bits)
      OpenSSL::BN::rand(bits).to_i
    end

    def self.random_prime(bits)
      OpenSSL::BN::generate_prime(bits).to_i
    end

    def self.modular_pow( base, power, mod )
      res = 1
      while power > 0
        res = (res * base) % mod if power & 1 == 1
        base = base ** 2 % mod
        power >>= 1
      end
      res
    end

    def self.mod_inverse(num, mod)
      g, a, b = extended_gcd(num, mod)
      unless g == 1
        raise ZeroDivisionError.new("#{num} has no inverse modulo #{mod}")
      end
      a % mod
    end

    def self.extended_gcd(x, y)
      if x < 0
        g, a, b = extended_gcd(-x, y)
        return [g, -a, b]
      end
      if y < 0
        g, a, b = extended_gcd(x, -y)
        return [g, a, -b]
      end
      r0, r1 = x, y
      a0 = b1 = 1
      a1 = b0 = 0
      until r1.zero?
        q = r0 / r1
        r0, r1 = r1, r0 - q*r1
        a0, a1 = a1, a0 - q*a1
        b0, b1 = b1, b0 - q*b1
      end
      [r0, a0, b0]
    end

    def self.crt(a0, a1, n)
      a = []
      a << a0
      a << a1

      y = []
      y << 0
      y << 1

      # puts "a0 = #{a0}, a1 = #{a1}, y0 = #{y[0]}, y1 = #{y[1]}"

      i = 1
      while(a[i] > n)
        q = (a[i-1]/a[i]).floor
        a << a[i-1] - q*a[i]
        y << y[i-1] + q*y[i]
        i = i + 1
        # puts "q = #{q}, a = #{a}, y = #{y}, i = #{i}"
      end

      Rational((-1)**(i+1) * a[i],y[i])
    end

  end
end
