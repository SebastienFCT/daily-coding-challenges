## Description

This problem was asked by Airbnb.

You are given an array `X` of floating-point numbers `x1`, `x2`, ... `xn`. These can be rounded up or down to create a corresponding array `Y` of integers `y1`, `y2`, ... `yn`.

Write an algorithm that finds an appropriate `Y` array with the following properties:

- The rounded sums of both arrays should be equal.
- The absolute pairwise difference between elements is minimized. In other words, `|x1- y1| + |x2- y2| + ... + |xn- yn|` should be as small as possible.

For example, suppose your input is `[1.3, 2.3, 4.4]`. In this case you cannot do better than `[1, 2, 5]`, which has an absolute difference of `|1.3 - 1| + |2.3 - 2| + |4.4 - 5| = 1`.

## Solution

```swift
extension Array where Element == Double {
    
    func roundedArrayWithSmallerPairwiseDiff() -> [Int] {
        
        var candidates = roundedArrayWithSmallerPairwiseDiff(current: [])
        for i in stride(from: candidates.count-1, through: 0, by: -1) {
            if candidates[i] == [] {
                candidates.remove(at: i)
            }
        }
        
        var index = 0
        var diff = Double(Int.max)
        
        for i in 0..<candidates.count {
            
            var newDiff: Double = 0
            
            for j in 0..<count {
                newDiff += (abs(Double(candidates[i][j]) - self[j]))
            }
            
            if newDiff < diff {
                diff = newDiff
                index = i
            }
        }
        
        return candidates[index]
    }
    
    private func roundedArrayWithSmallerPairwiseDiff(current: [Int]) -> [[Int]] {
        
        if current.count == count {
            
            let roundedOriginalSum = Int(self.reduce(0) { $0 + $1 }.rounded())
            let currentSum = current.reduce(0) { $0 + $1 }
            
            if roundedOriginalSum == currentSum {
                return [current]
            } else {
                return []
            }
        }
        
        var candidates: [[Int]] = []
        
        var candidate1 = current
        candidate1.append(Int(floor(self[current.count])))
        candidates.append(contentsOf: self.roundedArrayWithSmallerPairwiseDiff(current: candidate1))
        
        var candidate2 = current
        candidate2.append(Int(ceil(self[current.count])))
        candidates.append(contentsOf: self.roundedArrayWithSmallerPairwiseDiff(current: candidate2))
        
        return candidates
    }
}
```

## Tests

```swift
class Problem_355Tests: XCTestCase {

    func test_example() {
        let input: [Double] = [1.3, 2.3, 4.4]
        
        let actual = input.roundedArrayWithSmallerPairwiseDiff()
        let expected = [1, 2, 5]
        
        XCTAssert(actual == expected)
    }

}
```