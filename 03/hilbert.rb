require '../lib/turtle_graphics/turtle'

def hilbert_a(turtle, len, deep)
  unless deep.zero?
    turtle.left(90)
    hilbert_b(turtle, len, deep-1)
    turtle.forward(len)
    turtle.right(90)
    hilbert_a(turtle, len, deep-1)
    turtle.forward(len)
    hilbert_a(turtle, len, deep-1)
    turtle.right(90)
    turtle.forward(len)
    hilbert_b(turtle, len, deep-1)
    turtle.left(90)
  end
end

def hilbert_b(turtle, len, deep)
  unless deep.zero?
    turtle.right(90)
    hilbert_a(turtle, len, deep-1)
    turtle.forward(len)
    turtle.left(90)
    hilbert_b(turtle, len, deep-1)
    turtle.forward(len)
    hilbert_b(turtle, len, deep-1)
    turtle.left(90)
    turtle.forward(len)
    hilbert_a(turtle, len, deep-1)
    turtle.right(90)
  end
end

# Representation as Lindenmayer system:
#   {http://en.wikipedia.org/wiki/Hilbert_curve}
#
# Alphabet : A, B
# Constants : F + -
# Axiom : A
# Production rules:
#     A → - B F + A F A + F B -
#     B → + A F - B F B - F A +
def hilbert(turtle, len, deep)
  l = len/2**deep
  hilbert_a(turtle, l, deep)
end

if __FILE__ == $0
  deep = ARGV[0].to_i.zero? ?  7 : ARGV[0].to_i
  len = ARGV[1].to_i.zero? ? 1024 : ARGV[1].to_i

  # size = 2**deep

  # turtle = Turtle::Turtle.new(size+2, size+2, { :angle => 0, :x => 1, :y => 1 })
  turtle = Turtle::Turtle.new(len, len, { :angle => 0, :x => 2, :y => 2 })
  hilbert(turtle, len, deep)
  turtle.write('outputs/turtle_hilbert.svg')
end
