## Description

This problem was asked by Alibaba.

Given an even number (greater than 2), return two prime numbers whose sum will be equal to the given number.

A solution will always exist. See [Goldbach’s conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture).

Example:

```
Input: 4
Output: 2 + 2 = 4
```

If there are more than one solution possible, return the lexicographically smaller solution.

If [a, b] is one solution with a <= b, and [c, d] is another solution with c <= d, then

```
[a, b] < [c, d]
```

If a < c OR a==c AND b < d.

## Solution

```swift
func findPrimeCouple(forValue value: Int) -> (first: Int, second: Int) {
    
    guard value % 2 == 0 && value > 2 else {
        fatalError("value must be even and greater than 2")
    }
    
    var allPrimes: [Int] = []
    
    for i in 2...value {
        if allPrimes.containsDivider(forValue: i) {
            continue
        }
        
        allPrimes.append(i)
        
        for j in i...value {
            if allPrimes.containsDivider(forValue: j) {
                continue
            }
            
            allPrimes.append(j)
            
            if i + j == value {
                return (i, j)
            }
        }
    }
    
    fatalError("Didn't find a couple for the value \(value)")
}

extension Array where Element == Int {
    func containsDivider(forValue value: Int) -> Bool {
        
        for item in self {
            if value != item && value % item == 0 {
                return true
            }
        }
        
        return false
    }
}
```

## Test

```swift
class Problem_101Tests: XCTestCase {

    func test_simple() {
        XCTAssert(findPrimeCouple(forValue: 4) == (2, 2))
    }
    
    func test_even_up_to_1000() {
        var i = 2
        
        while i <= 1000 {
            i += 2
            
            let couple = findPrimeCouple(forValue: i)
            XCTAssert(couple.first != 0 && couple.second != 0)
        }
    }

}
```