## Description

This problem was asked by Flipkart.

Starting from 0 on a number line, you would like to make a series of jumps that lead to the integer N.

On the ith jump, you may move exactly i places to the left or right.

Find a path with the fewest number of jumps required to get from 0 to N.

## Solution

```swift
extension Int {
    
    // Solution comes from https://www.geeksforgeeks.org/find-the-number-of-jumps-to-reach-x-in-the-number-line-from-zero/
    
    func flipkartJumpCount() -> Int {
        
        let n = abs(self)
        var result = 0
        
        // If I understand bitwise AND operator, it should return either 00000000 if the bit value is XXXXXXX0 and 00000001 otherwise since 1 = 00000001
        // 2 = 00000010
        // 3 = 00000011
        // 4 = 00000100
        // 5 = 00000101 etc... so all odd number have their last bit = 1
        
        while result.sumCount() < n || ((result.sumCount() - n) & 1) > 0 {
            print("current: \(result)")
            result += 1
        }
        
        return result
    }
    
    private func sumCount() -> Int {
        
        return (self * (self + 1)) / 2
    }
}
```

## Tests

```swift
class Problem_322Tests: XCTestCase {

    func test_flipkart_jumps() {
        print(2.flipkartJumpCount())
    }

}
```