require 'pp'

SIZE=60

NEW_DIRECTION = {
  :up => :right,
  :right => :down,
  :down => :left,
  :left => :up
}

DIRECTIONS = {
  :up => [0, -1],
  :right => [1, 0],
  :down => [0, 1],
  :left => [-1, 0]
}

def in_range(x, y)
  x.between?(0, SIZE-1) && y.between?(0, SIZE-1)
end

def move(x, y, direction)
  [x + DIRECTIONS[direction].first, y + DIRECTIONS[direction].last]
end

def build_curve(opt)
  x,y = opt[:x], opt[:y]
  opt[:map][x][y] = 'X'

  opt[:fib].last.times do
    x,y = move x, y, opt[:direction]
    opt[:map][x][y] = 'X' if in_range(x,y)
  end

  if in_range(x,y)
    return build_curve :x => x, :y => y, :fib => [opt[:fib].last, opt[:fib].reduce(:+)], :map => opt[:map], :direction => NEW_DIRECTION[opt[:direction]]
  else
    return opt[:map]
  end
end

map = SIZE.times.map do
  [" "]*SIZE
end

build_curve :x => (SIZE/2).to_i, :y => (SIZE/2).to_i, :fib => [0,1], :map => map, :direction => :up
puts map.map(&:join).join("\n")

