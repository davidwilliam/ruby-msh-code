require "minitest/autorun"
# require 'minitest/hooks/default'

require Dir.pwd + "/x"

class TestMSHCode < Minitest::Test

  def test_initialization
    lambda = 128
    code = X::MSHCode.new lambda

    assert_equal lambda, code.p1.bit_length
    assert_equal lambda, code.p2.bit_length
    assert_equal 0, code.g % code.p1
    assert_equal 0, code.g % code.p2
    assert_equal (code.p1 * code.p2), code.g
  end

  def test_encoding_decoding
    lambda = 128
    code = X::MSHCode.new lambda

    m1 = X::Tools.random_number(8)
    m2 = X::Tools.random_number(8)
    m3 = X::Tools.random_number(8)
    m4 = X::Tools.random_number(8)

    beta1 = code.encode(m1)
    beta2 = code.encode(m2)
    beta3 = code.encode(m3)
    beta4 = code.encode(m4)

    assert_equal m1, code.decode(beta1)
    assert_equal m2, code.decode(beta2)
    assert_equal m3, code.decode(beta3)
    assert_equal m4, code.decode(beta4)
  end

  def test_homomorphic_addition
    lambda = 128
    code = X::MSHCode.new lambda

    m1 = X::Tools.random_number(8)
    m2 = X::Tools.random_number(8)
    m3 = X::Tools.random_number(8)
    m4 = X::Tools.random_number(8)

    m1_add_m2_add_m3_add_m4 = m1 + m2 + m3 + m4

    beta1 = code.encode(m1)
    beta2 = code.encode(m2)
    beta3 = code.encode(m3)
    beta4 = code.encode(m4)

    sum = code.add(beta1,beta2)
    sum = code.add(sum,beta3)
    sum = code.add(sum,beta4)

    sum_d = code.decode(sum)

    assert_equal m1_add_m2_add_m3_add_m4, sum_d
  end

  def test_homomorphic_multiplication
    lambda = 128
    code = X::MSHCode.new lambda

    m1 = X::Tools.random_number(8)
    m2 = X::Tools.random_number(8)
    m3 = X::Tools.random_number(8)
    m4 = X::Tools.random_number(8)

    m1_mul_m2_mul_m3_mul_m4 = m1 * m2 * m3 * m4

    beta1 = code.encode(m1)
    beta2 = code.encode(m2)
    beta3 = code.encode(m3)
    beta4 = code.encode(m4)

    mul = code.mul(beta1,beta2)
    mul = code.mul(mul,beta3)
    mul = code.mul(mul,beta4)

    mul_d = code.decode(mul)

    assert_equal m1_mul_m2_mul_m3_mul_m4, mul_d
  end

  def test_mixed_homomorphic_operations
    lambda = 128
    code = X::MSHCode.new lambda

    m1 = X::Tools.random_number(8)
    m2 = X::Tools.random_number(8)
    m3 = X::Tools.random_number(8)
    m4 = X::Tools.random_number(8)

    op = m1 * m2 + m3 * m4

    beta1 = code.encode(m1)
    beta2 = code.encode(m2)
    beta3 = code.encode(m3)
    beta4 = code.encode(m4)

    hop1 = code.mul(beta1,beta2)
    hop2 = code.mul(beta3,beta4)
    hop = code.add(hop1,hop2)

    hop_d = code.decode(hop)

    assert_equal op, hop_d
  end

  def test_dot_product
    lambda = 128
    code = X::MSHCode.new lambda

    a = Array.new(4){ X::Tools.random_number(8) }
    b = Array.new(4){ X::Tools.random_number(8) }

    a_dot_b = a[0]*b[0] + a[1]*b[1] + a[2]*b[2] + a[3]*b[3]

    beta_a = a.map{|aa| code.encode(aa)}
    beta_b = b.map{|bb| code.encode(bb)}

    beta_a_dot_beta_b = beta_a[0]*beta_b[0] + beta_a[1]*beta_b[1] + beta_a[2]*beta_b[2] + beta_a[3]*beta_b[3]

    beta_a_dot_beta_b_d = code.decode(beta_a_dot_beta_b)

    assert_equal a_dot_b, beta_a_dot_beta_b_d
  end
end
