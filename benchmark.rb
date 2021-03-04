require 'benchmark'

Benchmark.bm 7 do |r|
  array = 100_000.times.map{ rand(0..3) }
  # array = [1,2,1,3,0,2,0,1,3,2,1,0,0,2,1,3,.........]みたいな感じで0~3のランダムな数字が10万個入ってる
  sum = 0
  r.report "if" do
    array.each do |n|
      if n == 1
        sum += 1
      elsif n == 2
        sum += 2
      elsif n == 3
        sum += 3
      else
        sum
      end
    end
  end
  r.report "case" do
    array.each do |n|
      case n
      when 1
        sum += 1
      when 2
        sum += 2
      when 3
        sum += 3
      else
        sum
      end
    end
  end
end

Benchmark.bm 7 do |r|
  array = 100_000.times.map{ rand }
  r.report "each" do
    sum = 0
    array.each { |n| sum+=n }
  end
  r.report "inject" do
    sum = array.inject(0){ |result, n| result+n }
  end
end

Benchmark.bm 7 do |r|
  array = []
  n = 0
  r.report "push" do
    while n < 100_000 do
      array.push(n)
      n += 1
    end
  end
  r.report "<<" do
    while  n < 100_000 do
      array << n
      n += 1
    end
  end
end