## Description

This problem was asked by Google.

A girl is walking along an apple orchard with a bag in each hand. She likes to pick apples from each tree as she goes along, but is meticulous about not putting different kinds of apples in the same bag.

Given an input describing the types of apples she will pass on her path, in order, determine the length of the longest portion of her path that consists of just two types of apple trees.

For example, given the input `[2, 1, 2, 3, 3, 1, 3, 5]`, the longest portion will involve types `1` and `3`, with a length of four.

## Solution

```swift
extension Array where Element == Int {
    
    func longestPortionForAnyPair() -> (length: Int, pair: (Int, Int)) {
        
        var result: (length: Int, pair: (Int, Int)) = (0, (0, 0))
        
        var first: Int? = nil
        var last: Int? = nil
        
        var lastCount = 0
        var length = 0
        
        for element in self {
            
            if first == nil {
                first = element
                length += 1
                
                continue
            }
            
            if element == first {
                
                if last == nil {
                    lastCount += 1
                } else {
                    lastCount = 1
                    
                    let tmp = first
                    first = last
                    last = tmp
                }
                
                length += 1
                
                continue
            }
            
            if last == nil {
                last = element
                lastCount += 1
                length += 1
                
                continue
            }
            
            if element == last {
                lastCount += 1
                length += 1
                
                continue
            }
            
            if length > result.length {
                result.length = length
                result.pair.0 = first!
                result.pair.1 = last!
            }
            
            let tmp = last
            last = element
            first = tmp
            length = lastCount + 1
            lastCount = 1
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_298Tests: XCTestCase {

    func test_example() {
        
        let input = [2, 1, 2, 3, 3, 1, 3, 5]
        let actual = input.longestPortionForAnyPair()
        
        XCTAssert(actual.length == 4)
        XCTAssert(actual.pair.0 == 1 && actual.pair.1 == 3)
    }

}
```