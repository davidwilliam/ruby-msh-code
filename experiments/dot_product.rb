require './x'

lambda = 1024
code = X::MSHCode.new lambda

a = Array.new(4){ X::Tools.random_number(8) }
b = Array.new(4){ X::Tools.random_number(8) }

a_dot_b = a[0]*b[0] + a[1]*b[1] + a[2]*b[2] + a[3]*b[3]

beta_a = a.map{|aa| code.encode(aa)}
beta_b = b.map{|bb| code.encode(bb)}

beta_a_dot_beta_b_1 = code.add(code.mul(beta_a[0],beta_b[0]),code.mul(beta_a[1],beta_b[1]))
beta_a_dot_beta_b_2 = code.add(code.mul(beta_a[2],beta_b[2]),code.mul(beta_a[3],beta_b[3]))
beta_a_dot_beta_b = code.add(beta_a_dot_beta_b_1,beta_a_dot_beta_b_2)

beta_a_dot_beta_b_d = code.decode(beta_a_dot_beta_b)

puts "\n\nMSH Code: Dot product example\n\n"

puts "Given the two vectors:\n\n"

puts "a = #{a}"
puts "b = #{b}\n\n"

puts "a_dot_b = #{a_dot_b}\n\n"

puts "Encoded vectors a and b:\n\n"

puts "beta_a = #{beta_a}\n\n"
puts "beta_b = #{beta_b}\n\n"

puts "Decoded vectors for a and b:\n\n"

puts "beta_a_dot_beta_b_d = #{beta_a_dot_beta_b_d}\n\n"

puts "And we check that a_dot_b = beta_a_dot_beta_b_d\n\n"
