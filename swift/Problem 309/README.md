## Description

This problem was asked by Walmart Labs.

There are `M` people sitting in a row of `N` seats, where `M < N`. Your task is to redistribute people such that there are no gaps between any of them, while keeping overall movement to a minimum.

For example, suppose you are faced with an input of `[0, 1, 1, 0, 1, 0, 0, 0, 1]`, where `0` represents an empty seat and `1` represents a person. In this case, one solution would be to place the person on the right in the fourth seat. We can consider the cost of a solution to be the sum of the absolute distance each person must move, so that the cost here would be five.

Given an input such as the one above, return the lowest possible cost of moving people to remove all gaps.

## Solution

```swift
extension Array where Element == Int {
    
    // Calling it defragmentation as it reminds me these degragmentation diagram on Windows 98: https://www.youtube.com/watch?v=dc_SDyLYq3U
    func minCostForDefragmentation() -> Int? {
        
        guard (filter{ $0 != 1 && $0 != 0 }.count == 0) else {
            fatalError("Invalid input. Must be an array of 0 and 1")
        }
        
        if validFragmentation() {
            return 0
        }
        
        return costForNextMove(currentCost: 0, passedThrough: [])
    }
    
    private func costForNextMove(currentCost: Int, passedThrough: [Int]) -> Int? {
        
        var candidates: [Int] = []
        
        if validFragmentation() {
            return currentCost
        }
        
        for i in 0..<count-1 {
            if passedThrough.contains(i) {
                continue
            }
            
            if self[i] == 0 {
                
                for j in 0..<self.count {
                    var copy = self
                    if j == i {
                        continue
                    }
                    
                    if passedThrough.contains(j) {
                        continue
                    }
                    
                    if copy[j] == 1 {
                        copy[i] = 1
                        copy[j] = 0
                        var newPassedThrough = passedThrough
                        newPassedThrough.append(i)
                        newPassedThrough.append(j)
                        var newCost = currentCost
                        newCost += abs(j-i)
                        
                        if let candidate = copy.costForNextMove(currentCost: newCost, passedThrough: newPassedThrough) {
                            candidates.append(candidate)
                        }
                    }
                }
            }
        }
        
        return candidates.min()
    }
    
    private func validFragmentation() -> Bool {
        
        var copy = self
        while copy.first == 0 {
            copy.removeFirst()
        }
        
        var previous = true
        
        for i in 1..<copy.count {
            
            if copy[i] == 1 {
                if previous {
                    continue
                } else {
                    return false
                }
            }
            
            if copy[i] == 0 {
                if previous {
                    previous = false
                } else {
                    continue
                }
            }
        }
        
        return true
    }
}
```

## Tests

```swift
class Problem_309Tests: XCTestCase {

    func test_example() {
        
        let input = [0, 1, 1, 0, 1, 0, 0, 0, 1]
        
        let actual = input.minCostForDefragmentation()
        let expected = 5
        
        XCTAssert(actual == expected)
    }

}
```