## Description

This problem was asked by PagerDuty.

Given a positive integer `N`, find the smallest number of steps it will take to reach `1`.

There are two kinds of permitted steps:

- You may decrement `N` to `N - 1`.
- If `a * b = N`, you may decrement `N` to the larger of `a` and `b`.

For example, given `100`, you can reach `1` in five steps with the following route: `100 -> 10 -> 9 -> 3 -> 2 -> 1`.

## Solution

```swift
extension Int {
    
    func lowestStepCountToOne() -> Int {
        
        if self == 2 {
            return 1
        }
        
        if self == 1 {
            return 0
        }
        
        var stepCount = 1
        
        let path1 = (self-1).lowestStepCountToOne()
        let option2 = self.highestDivider()
        
        if option2 != self {
            stepCount += Swift.min(path1, option2.lowestStepCountToOne())
        } else {
            stepCount += path1
        }
        
        return stepCount
    }
    
    private func highestDivider() -> Int {
        
        var higher = self
        
        for i in stride(from: self, through: 1, by: -1) {
            if self % i == 0 {
                let largest = Swift.max(i, self / i)
                
                if higher > largest {
                    higher = largest
                }
            }
        }
        
        return higher
    }
}
```

## Tests

```swift
class Problem_321Tests: XCTestCase {

    func test_example() {
        
        let input = 100
        
        let actual = input.lowestStepCountToOne()
        let expected = 5
        
        XCTAssert(actual == expected)
    }

}
```