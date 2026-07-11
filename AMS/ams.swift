#!/usr/bin/swift

import Foundation

// swiftc -o ams ams.swift

let order = 5

struct Cell {
    var clue: String       // e.g. "TOWEL"
    var number: Int        // e.g. 2
    var solution: String   // e.g. "OWLET"

    init(clue: String = "", number: Int = 0, solution: String = "") {
        self.clue = clue
        self.number = number
        self.solution = solution
    }
}

let grid = magicify(order: order)
print(grid: grid, order: order)

// --------------------------------------------------
func magicify(order: Int) -> [[Cell]] {
    var grid = [[Cell]](repeating: [Cell](repeating: Cell(), count: order),
                        count: order)
    var row = 0
    var column = order / 2
    var number = 1
    grid[row][column].number = number

    var loopNumber = 0

    while number <= order * order {
        if loopNumber > 50 { break }
        loopNumber += 1

        print(grid: grid, order: order)

        let oldRow = row
        let oldColumn = column
        
        // go up and left
        row -= 1
        column -= 1

        // if fall off the edge, pretend things are tiled
        if row < 0 { row = order - 1 }
        if column < 0 { column = order - 1}

        print("looking at \(row) \(column)")

        if grid[row][column].number == 0 {
            print("yay")
            number = number + 1
            grid[row][column].number = number
        } else {
            print("collide")
            // undo prior move

            // move down instead
            row = oldRow + 1
            column = oldColumn

            if row > order - 1 { row = 0 }
            print("    colliding \(oldRow) \(oldColumn) -> \(row) \(column)")

            if grid[row][column].number != 0 {
                print("this is occupied?")
                continue
            }
            number = number + 1
            grid[row][column].number = number
        }
    }

    return grid
}

// --------------------------------------------------

func print(grid: [[Cell]], order: Int) {
    for row in 0 ..< order {
        for column in 0 ..< order {
            let fmt = String(format: "%5d", grid[row][column].number)
            print(fmt, terminator: "")
        }
        print("\n")
    }
}
