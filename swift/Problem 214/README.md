## Description

This problem was asked by Stripe.

Given an integer n, return the length of the longest consecutive run of 1s in its binary representation.

For example, given `156`, you should return `3`.

## Solution

```swift
extension Int {
    
    func longestConsecutiveOnes() -> Int {
        return longestConsecutive(value: 1)
    }
    
    func longestConsecutive(value: Int) -> Int {
        return self.bitRepresentation().longestConsecutive(value: value)
    }
    
    func bitRepresentation() -> [Int] {
        let bitRepresentation = String(self, radix: 2)
        
        var result: [Int] = []
        
        for char in bitRepresentation {
            result.append(Int(String(char))!)
        }
        
        return result
    }
}

extension Array where Element == Int {
    
    func longestConsecutive(value: Int) -> Int {
        
        var max = 0
        
        for i in 0..<count-1 {
            
            var current = 0
            
            for j in i..<count {
                if self[j] != value {
                    break
                }
                
                current += 1
                if current > max { max = current }
            }
        }
        
        return max
    }
}
```

## Test

```swift
class Problem_214Tests: XCTestCase {

    func test_example() {
        print(156.longestConsecutiveOnes())
    }

}
```