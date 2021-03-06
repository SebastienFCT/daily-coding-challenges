## Description

This problem was asked by Twitter.

Given a list of numbers, create an algorithm that arranges them in order to form the largest possible integer. For example, given `[10, 7, 76, 415]`, you should return `77641510`.


## Solution

```swift
extension Array where Element == Int {
    
    func maximumConcat() -> Int {
        
        var candidates: [[Int]] = []
        
        for i in 0..<count {
            var copy = self
            var row: [Int] = []
            row.append(copy.remove(at: i))
            candidates.append(contentsOf: [row].next(remaining: copy))
        }
        
        let mapped = candidates.map{
            $0.reduce("") { return "\($0)\($1)" }
        }
        
        let toInt: [Int] = mapped.map{ Int($0) ?? 0 }
        let sorted = toInt.sorted{ $0 > $1 }
        
        return sorted.first ?? 0
    }
}

extension Array where Element == Array<Int> {
    
    func next(remaining: [Int]) -> [[Int]] {
        
        var result: [[Int]] = []
        
        for item in self {
            for i in 0..<remaining.count {
                var copy = remaining
                let value = copy.remove(at: i)
                
                var current = item
                current.append(value)
                
                if copy.isEmpty {
                    result.append(current)
                } else {
                    result.append(contentsOf: [current].next(remaining: copy))
                }
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_228Tests: XCTestCase {

    func test_example() {
        
        let actual = [10, 7, 76, 415].maximumConcat()
        let expected = 77641510
        
        XCTAssert(actual == expected)
    }

}
```