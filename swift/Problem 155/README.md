## Description

This problem was asked by MongoDB.

Given a list of elements, find the majority element, which appears more than half the time (`> floor(len(lst) / 2.0)`).

You can assume that such element exists.

For example, given `[1, 2, 1, 1, 3, 4, 0]`, return 1.

## Solution

```swift
extension Array where Element == Int {
    func findElementThatAppearTheMost() -> Int? {
        
        let distribution = repartition()
        
        return distribution.max{ a, b in a.value < b.value }?.key
    }
    
    private func repartition() -> [Int: Int] {
        var result: [Int: Int] = [:]
        
        for element in self {
            if result.keys.contains(element) {
                result[element]! += 1
            } else {
                result[element] = 1
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_155Tests: XCTestCase {

    func test_example() {
        XCTAssert([1, 2, 1, 1, 3, 4, 0].findElementThatAppearTheMost() == 1)
    }

}
```