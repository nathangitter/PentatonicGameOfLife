import Foundation

struct Preset {
    
    static var empty: [[Bool]] {
        let array = [
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
        ]
        return convert(array: array)
    }
    
    static var swift: [[Bool]] {
        let array = [
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,1,0,0,0,0,0],
            [0,0,0,0,1,0,0,1,0,0,0,0],
            [0,0,0,1,0,1,0,1,0,0,0,0],
            [0,0,0,0,1,1,1,1,1,0,0,0],
            [0,0,1,0,0,0,1,1,1,0,0,0],
            [0,0,0,1,1,1,1,1,0,0,0,0],
            [0,0,0,0,0,1,1,0,1,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
        ]
        return convert(array: array)
    }
    
    static var heart: [[Bool]] {
        let array = [
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,1,1,0,0,1,1,0,0,0],
            [0,0,1,0,0,1,1,0,0,1,0,0],
            [0,1,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,1,0],
            [0,1,0,0,0,0,0,0,0,0,1,0],
            [0,0,1,0,0,0,0,0,0,1,0,0],
            [0,0,0,1,0,0,0,0,1,0,0,0],
            [0,0,0,0,1,0,0,1,0,0,0,0],
            [0,0,0,0,0,1,1,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
        ]
        return convert(array: array)
    }
    
    static var glider: [[Bool]] {
        let array = [
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,1,0,0,0,0,0,0,0,0,0],
            [0,0,0,1,0,0,0,0,0,0,0,0],
            [0,1,1,1,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
        ]
        return convert(array: array)
    }
    
    static var oscillator: [[Bool]] {
        let array = [
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,1,1,1,0,0,0,0,0,0],
            [0,0,0,1,1,1,0,0,0,0,0,0],
            [0,0,0,1,1,1,0,0,0,0,0,0],
            [0,0,0,0,0,0,1,1,1,0,0,0],
            [0,0,0,0,0,0,1,1,1,0,0,0],
            [0,0,0,0,0,0,1,1,1,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0],
        ]
        return convert(array: array)
    }
    
    static var random: [[Bool]] {
        var array = [[Int]]()
        for _ in 0 ..< 12 {
            var row = [Int]()
            for _ in 0 ..< 12 {
                let value = Double(arc4random_uniform(100)) / 100 < 0.1 ? 1 : 0
                row.append(value)
            }
            array.append(row)
        }
        return convert(array: array)
    }
    
    /// Converts between the easy to design format and easy to use format.
    private static func convert(array: [[Int]]) -> [[Bool]] {
        var newArray = Array(repeating: [Bool](), count: 12)
        for row in array {
            for (j, int) in row.enumerated() {
                newArray[j].insert(int == 1, at: 0)
            }
        }
        return newArray
    }
    
}
