## Description

This problem was asked by Uber.

Write a program that determines the smallest number of perfect squares that sum up to `N`.

Here are a few examples:

- Given `N = 4`, return `1` (4)
- Given `N = 17`, return `2` (16 + 1)
- Given `N = 18`, return `2` (9 + 9)

## Solution

```swift
extension Int {
    
    func minimumTupleOrPerfectSquareWithMatchingSum() -> Int? {
        
        var index = 1
        var squares: [Int] = [1]
        
        while squares.last! <= self {
            index += 1
            squares.append(index*index)
        }
        
        squares.removeLast()
        
        let candidates = squares.tuples(current: [], total: self)
        let sorted = candidates.sorted{ $0.count < $1.count }
        
        return sorted.first?.count
    }
}

extension Array where Element == Int {
    
    func tuples(current: [Int], total: Int) -> [[Int]] {
        
        var result: [[Int]] = []
        
        for i in 0..<count {
            
            if self[i] < total {
                
                var newCurrent = current
                newCurrent.append(self[i])
                
                result.append(contentsOf: self.tuples(current: newCurrent, total: total-self[i]))
            }
            
            if self[i] == total {
                var newCurrent = current
                newCurrent.append(self[i])
                
                result.append(newCurrent)
            }
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_350Tests: XCTestCase {

    func test_example() {

        XCTAssert(4.minimumTupleOrPerfectSquareWithMatchingSum() == 1)
        XCTAssert(17.minimumTupleOrPerfectSquareWithMatchingSum() == 2)
        XCTAssert(18.minimumTupleOrPerfectSquareWithMatchingSum() == 2)
    }
}
```