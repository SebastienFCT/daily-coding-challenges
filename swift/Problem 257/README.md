## Description

This problem was asked by WhatsApp.

Given an array of integers out of order, determine the bounds of the smallest window that must be sorted in order for the entire array to be sorted. For example, given `[3, 7, 5, 6, 9]`, you should return `(1, 3)`.

## Solution

```swift
extension Array where Element == Int {

    typealias Boundary = (start: Int, end: Int)

    func boundForSmallestWindowToSort() -> Boundary {
        
        var boundary: Boundary  = (0, count-1)
        let copy = self.sorted{ $0 < $1 }
        
        for i in 0..<count {
            if copy[i] != self[i] {
                boundary.start = i
                break
            }
        }
        
        for i in stride(from: count-1, through: 0, by: -1) {
            if copy[i] != self[i] {
                boundary.end = i
                break
            }
        }
        
        return boundary
    }
}
```

## Tests

```swift
class Problem_257Tests: XCTestCase {

    func test_example() {
        let input = [3, 7, 5, 6, 9]
        let actual = input.boundForSmallestWindowToSort()
        let expected = (1, 3)
        
        XCTAssert(actual == expected)
    }

}
```