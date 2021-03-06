## Description

This problem was asked by Pinterest.

The sequence `[0, 1, ..., N]` has been jumbled, and the only clue you have for its order is an array representing whether each number is larger or smaller than the last. Given this information, reconstruct an array that is consistent with it. For example, given `[None, +, +, -, +]`, you could return `[1, 2, 3, 0, 4]`.

## Solution

```swift
struct JumbledSequence {
    
    // Solution found at https://github.com/vineetjohn/daily-coding-problem
    
    func solve(input: [Character]) -> [Int] {
        
        guard (input.filter{ $0 != "+" && $0 != "-"  }.count == 0) else {
            fatalError("input invalid")
        }
        
        var result: [Int] = []
        let addCount = input.filter{ $0 == "+" }.count
        
        let firstValue = input.count - addCount
        var smallerValue = firstValue - 1
        var greaterValue = firstValue + 1
        
        result.append(firstValue)
        
        for i in 0..<input.count {
            if input[i] == "+" {
                result.append(greaterValue)
                greaterValue += 1
            } else {
                result.append(smallerValue)
                smallerValue -= 1
            }
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_260Tests: XCTestCase {

    func test_example() {
        
        let js = JumbledSequence()
        let actual = js.solve(input: ["+", "+", "-", "+"])
        let expected = [1, 2, 3, 0, 4]
        
        XCTAssert(actual == expected)
    }

}
```