require "byebug"
class Board
    attr_reader :size

    def initialize(number)
        @grid = Array.new(number) {Array.new(number, :N)}
        @size = number * number
    end

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, val)
        @grid[position[0]][position[1]] = val
    end

    def num_ships
    count = 0
    i = 0
    while i < @grid.length
        (0...@grid.length).each do |j|
            count += 1 if @grid[i][j] == :S
        end
        i += 1
    end
    count
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts "you sunk my battleship!"
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        max_ships = @size * 0.25
        while self.num_ships < max_ships
            row = rand(@grid.length)
            col = rand(@grid.length)
            @grid[row][col] = :S
        end
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map do |el|
                if el == :S
                    :N
                else
                    el
                end
            end
        end
    end

    def self.print_grid(grid_arr)
        i = 0
        while i < grid_arr.length
            # puts "#{grid_arr[i][0]} #{grid_arr[i][1]}"
            puts grid_arr[i].join(" ")
            i += 1
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(self.hidden_ships_grid)
    end
end

