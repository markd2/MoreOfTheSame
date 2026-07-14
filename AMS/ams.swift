#!/usr/bin/swift

import Foundation

// swiftc -g -o ams ams.swift

let quote = "Stay kind, choose joy daily now."
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

var grid = magicify(order: order)
var solutions: [String] = [String](repeating: "", count: order * order)
printNumbers(grid: grid, order: order)

/*
var count = 0

while sanityCheck(grid: grid, order: order) {
    count += 1
    print("try \(count)")
}
*/

// now take a sentence, strip out all of the non-characters

let chars = Array(quote.filter { $0.isLetter }.uppercased().utf8)

// then pick two anagrams

var anagramList: [String: [[String]] ] = [
"A": [ ["ALERT", "ALTER"], ["ALONE", "ANOLE"] ],
"C": [ ["CATER", "TRACE"] ],
"D": [ ["DELTA", "DEALT"], ["DUSTY", "STUDY"] ],
"E": [ ["EARTH", "HEART"] ],
"H": [ ["HEART", "EARTH"] ],
"I": [ ["INERT", "NITER"], ["INLET", "INTEL"] ],
"J": [ ["JUNTA", "JAUNT"], ],
"K": [ ["KITES", "SKITE"] ],
"L": [ ["LEAST", "STALE"] ],
"N": [ ["NERVE", "NEVER"], ["NERVE", "NEVER"] ],
"O": [ ["OCEAN", "CANOE"], ["OLIVE", "VOILE"], ["ORATE", "OATER"], ["OPTIC", "TOPIC"], ["ONSET", "STONE"] ],
"S": [ ["STARE", "RATES"], ["SHEAR", "HEARS"], ["SCALE", "LACES"], ["SCARE", "ACRES"] ],
"T": [ ["TABLE", "BLEAT"] ],
"W": [ ["WASTE", "SWEAT"] ],
"Y": [ ["YURTS", "RUSTY"], ["YOMEN", "MONEY"], ["YEAST", "YEATS" ] ]
]

let questions = [
"ACRES": "Green ____",
"ALERT": "Red _____",
"ALONE": "Home ____",
"ALTER": "_____ ego",
"ANOLE": "Strange little lizard",
"BLEAT": "Sound a sheep makes",
"CANOE": "Trudy's obsession",
"CATER": "_____ a banqueet",
"DEALT": "Having handed out cards",
"DELTA": "We love to fly and it shows",
"DUSTY": "Covered in a fine powder",
"EARTH": "Dirt",
"HEARS": "Detected something aurally",
"HEART": "Lub dub lub dub",
"INERT": "",
"INLET": "",
"INTEL": "",
"JAUNT": "",
"JUNTA": "",
"KITES": "",
"LACES": "",
"LEAST": "",
"MONEY": "",
"NERVE": "",
"NEVER": "",
"NITER": "",
"OATER": "",
"OCEAN": "",
"OLIVE": "",
"ONSET": "",
"OPTIC": "",
"ORATE": "",
"RATES": "",
"RUSTY": "",
"SCALE": "",
"SCARE": "",
"SHEAR": "",
"SKITE": "",
"STALE": "",
"STARE": "",
"STONE": "",
"STUDY": "",
"SWEAT": "",
"TABLE": "",
"TOPIC": "",
"TRACE": "",
"VOILE": "",
"WASTE": "",
"YEAST": "All rise, all rise",
"YEATS": "A perne in a gyre",
"YOMEN": "_____ of the guard",
"YURTS": "There's no here, but there is room for U"
]

for row in 0 ..< order {
    for column in 0 ..< order {
        var cell = grid[row][column]
        let number = cell.number - 1

        let char = String(UnicodeScalar(chars[number]))

        // car
        var candidates = anagramList[char]!
        
        // cdr
        let candidate = candidates.removeFirst()
        anagramList[String(char)] = candidates

        cell.solution = candidate[0]
        cell.clue = candidate[1]

        solutions[number] = cell.clue

        grid[row][column] = cell
    }
}

printGrid(grid: grid, order: order)


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

func printNumbers(grid: [[Cell]], order: Int) {
    for row in 0 ..< order {
        for column in 0 ..< order {
            let fmt = String(format: "%3d", grid[row][column].number)
            print(fmt, terminator: "")
        }
        print("\n")
    }
}


func printGrid(grid: [[Cell]], order: Int) {
    for row in 0 ..< order {
        for column in 0 ..< order {
            let cell = grid[row][column]
            print("\(cell.solution)(\(cell.number))  ",
                  terminator: "")
        }
        print("\n")
    }
    for i in 0 ..< (order * order) - 1 {
        let solution = solutions[i]
        let question = questions[solution]!
        print("\(i) : \(solutions[i]) : \(question)")
    }
}


/* some quotes
Stay kind, choose joy daily now
Give more, expect little back
Simple acts spark great change
*/

/* some anagrams
{
"A": [ ["ALERT", "ALTER"], ["ALONE", "ANOLE"] ],
"C": [ ["CATER", "TRACE"] ],
"D": [ ["DELTA", "DEALT"], ["DUSTY", "STUDY"] ],
"E": [ ["EARTH", "HEART"] ],
"H": [ ["HEART", "EARTH"] ],
"I": [ ["INERT", "NITER"], ["INLET", "INTEL"] ],
"J": [ ["JUNTA", "JAUNT"], ["KITES", "SKITE"], ["LEAST", "STALE"] ],
"N": [ ["NERVE", "NEVER"], ["NERVE", "NEVER"] ],
"O": [ ["OCEAN", "CANOE"], ["OLIVE", "VOILE"], ["ORATE", "OATER"], ["OPTIC", "TOPIC"], ["ONSET", "STONE] ],
"S": [ ["STARE", "RATES"], ["STARE", "RATES"] ],
"T": [ ["TABLE", "BLEAT"] ],
"W": [ ["WASTE", "SWEAT"] ],
"Y": [ ["YURTS", "RUSTY"], ["YOMEN", "MONEY"] ]
}

*/



