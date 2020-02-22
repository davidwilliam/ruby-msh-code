class Gen
    attr_accessor :l, :p1, :p2, :p3, :p4, :r1, :r2, :g

    def initialize(l)
        @l = l
        @p1 = Tools.random_prime(l)
        @p2 = Tools.random_prime(l)
        @p3 = Tools.random_prime(l)
        @p4 = Tools.random_prime(l)
        @r1 = 1
        @r2 = 12
        @g = @p1**@r1 * @p2**@r1 * @p3**@r1 * @p4**@r2
    end

end
