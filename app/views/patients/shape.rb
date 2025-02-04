class Shape
    def piramid(rows)
        for row in 1..rows
            (rows - row).times { print " " }
            row.times { print "*" }
            (row - 1).times { print "*" }
            puts
        end
        for row in 1..rows
            row.times { print " " }
            (rows - row).times { print "*" }
            (rows - row - 1).times { print "*" }
            puts
        end
    end
end
Shape.new.piramid(5)