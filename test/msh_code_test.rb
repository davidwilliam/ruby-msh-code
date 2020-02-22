require "minitest/autorun"
# require 'minitest/hooks/default'

require Dir.pwd + "/x"

class TestMSHCode < Minitest::Test

  def test_initialization
    lambda = 8
    k = Gen.new lambda

    assert_equal lambda, k.p1.bit_length
    assert_equal lambda, k.p2.bit_length
    assert_equal lambda, k.p3.bit_length
    assert_equal lambda, k.p4.bit_length
    assert (k.r2 >= 6 * k.r1)
    assert_equal 0, k.g % k.p1
    assert_equal 0, k.g % k.p2
    assert_equal 0, k.g % k.p3
    assert_equal 0, k.g % k.p4
    assert_equal (k.p1**k.r1 * k.p2**k.r1 * k.p3**k.r1 * k.p4**k.r2), k.g
  end

  def test_encoding_decoding
    lambda = 16
    k = Gen.new lambda

    m1 = Tools.random_number(lambda / 2)
    m2 = Tools.random_number(lambda / 2)
    m3 = Tools.random_number(lambda / 2)
    m4 = Tools.random_number(lambda / 2)

    beta1 = MSHCode.encode(k,m1)
    beta2 = MSHCode.encode(k,m2)
    beta3 = MSHCode.encode(k,m3)
    beta4 = MSHCode.encode(k,m4)

    assert_equal m1, MSHCode.decode(k,beta1)
    assert_equal m2, MSHCode.decode(k,beta2)
    assert_equal m3, MSHCode.decode(k,beta3)
    assert_equal m4, MSHCode.decode(k,beta4)
  end

  def test_homomorphic_addition
    lambda = 16
    k = Gen.new lambda

    m1 = Tools.random_number(8)
    m2 = Tools.random_number(8)
    m3 = Tools.random_number(8)
    m4 = Tools.random_number(8)

    m1_add_m2_add_m3_add_m4 = m1 + m2 + m3 + m4

    beta1 = MSHCode.encode(k,m1)
    beta2 = MSHCode.encode(k,m2)
    beta3 = MSHCode.encode(k,m3)
    beta4 = MSHCode.encode(k,m4)

    sum = MSHCode.add(k.g,beta1,beta2)
    sum = MSHCode.add(k.g,sum,beta3)
    sum = MSHCode.add(k.g,sum,beta4)

    sum_d = MSHCode.decode(k,sum)

    assert_equal m1_add_m2_add_m3_add_m4, sum_d
  end
end
