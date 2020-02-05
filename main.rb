
class Game

    def initialize
        @state = Hash.new('.')
        @state[[3,5]] = 'R'
    end

    def add_elk
        @state[[60, 5]] = Elk.new
    end

    def display
        a = (0..9).to_a
        puts a.join()
        (1..9).each do |y|
            a = [y]
            (2..60).each do |x|
                a += [@state[[x,y]].to_s]
            end
            puts a.join()
        end
    end
end

class Elk

    def to_s
        'e'
    end

end


g = Game.new
g.display

# puts "Place Towers"

puts "Elk will now attack the ruby"

g.add_elk
g.display
