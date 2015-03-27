#example of benchmarking from
# http://www.synbioz.com/blog/optimize_ruby_code
def fib(n)
  return n if (0..1).include? n
  fib(n-1) + fib(n-2) if n > 1
end

puts fib(ARGV[0].to_i)