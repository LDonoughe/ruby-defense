
class Game

    def initialize
        @state = [[]*9]
    end

    def display
        (1..9).each do |y|
            a = [y]
            (2..60).each do |x|
                if y == 5 && x == 10
                    a += ['R']
                else
                    a += ['.']
                end
            end
            puts a.join()
        end
    end
end

class Elk

end


g = Game.new
g.display

puts "Place Towers"