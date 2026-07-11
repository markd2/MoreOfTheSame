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

/*
var count = 0

while sanityCheck(grid: grid, order: order) {
    count += 1
    print("try \(count)")
}
*/

// --------------------------------------------------
func sanityCheck(grid: [[Cell]], order: Int) -> Bool {
    // S = n(n^2 + 1) / 2
    let expected = (order * (order*order + 1)) / 2
    
    for row in 0 ..< order {
        var sum = 0
        for c in 0 ..< order {
            sum += grid[row][c].number
        }
        if sum != expected {
            print("oops - row \(row) is \(sum), not \(expected)")
            return false
        }
    }

    for column in 0 ..< order {
        var sum = 0
        for r in 0 ..< order {
            sum += grid[r][column].number
        }
        if sum != expected {
            print("oops - column \(column) is \(sum), not \(expected)")
            return false
        }
    }
    return true
}

// --------------------------------------------------
func magicify(order: Int) -> [[Cell]] {
    var grid = [[Cell]](repeating: [Cell](repeating: Cell(), count: order),
                        count: order)
    /*
    var row = 0
    var column = order / 2
     */

    var row = Int.random(in: 0 ..< order)
    var column = Int.random(in: 0 ..< order)
    var number = 1
    grid[row][column].number = number

    var loopNumber = 0

    while number <= order * order {
        if loopNumber > 50 { break }
        loopNumber += 1

        let oldRow = row
        let oldColumn = column
        
        // go up and left
        row -= 1
        column -= 1

        // if fall off the edge, pretend things are tiled
        if row < 0 { row = order - 1 }
        if column < 0 { column = order - 1}

        if grid[row][column].number == 0 {
            number = number + 1
            grid[row][column].number = number
        } else {
            // move down instead
            row = oldRow + 1
            column = oldColumn

            if row > order - 1 { row = 0 }

            if grid[row][column].number != 0 {
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
            let fmt = String(format: "%3d", grid[row][column].number)
            print(fmt, terminator: "")
        }
        print("\n")
    }
}
