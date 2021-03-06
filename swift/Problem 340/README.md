## Description

This problem was asked by Google.

Given a set of points (x, y) on a 2D cartesian plane, find the two closest points. For example, given the points `[(1, 1), (-1, -1), (3, 4), (6, 1), (-1, -6), (-4, -3)]`, return `[(-1, -1), (1, 1)]`.

## Solution

```swift
typealias TwoDimensionalPoint = (Int, Int)

extension Array where Element == TwoDimensionalPoint {
    
    func closestPair() -> (left: TwoDimensionalPoint, right: TwoDimensionalPoint) {
        
        guard count > 1 else {
            fatalError("Not enough elements")
        }
        
        var left = self[0]
        var right = self[1]
        var distance = abs(left.0 - right.0) + abs(left.1 - right.1)
        
        for i in 0..<count-1 {
            for j in i+1..<count {
                
                let lCandidate = self[i]
                let rCandidate = self[j]
                
                let currentDistance = abs(lCandidate.0 - rCandidate.0) + abs(lCandidate.1 - rCandidate.1)
                
                if currentDistance < distance {
                    left = lCandidate
                    right = rCandidate
                    distance = currentDistance
                }
            }
        }
        
        return (left, right)
    }
}
```

## Tests

```swift
class Problem_340Tests: XCTestCase {

    func test_example() {
        let input: [TwoDimensionalPoint] = [(1, 1), (-1, -1), (3, 4), (6, 1), (-1, -6), (-4, -3)]
        
        let actual = input.closestPair()
        
        XCTAssert((actual.left == (1, 1) && actual.right == (-1, -1)) || (actual.left == (-1, -1) && actual.right == (1, 1)))
    }

}
```