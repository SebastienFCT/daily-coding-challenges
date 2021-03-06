## Description

This problem was asked by Salesforce.

Given an array of integers, find the maximum XOR of any two elements.

## Solution

```swift
extension Array where Element == Int {
    
    func xOrCount() -> Int {
        
        var results: [Int] = []
        
        for i in 0..<count-1 {
            for j in i+1..<count {
                
                var result = 0
                
                for k in 0..<count {
                    if (k == i || k == j) { continue }
                    
                    if ((self[k] == self[i] && self[k] != self[j]) || (self[k] != self[i] && self[k] == self[j])) {
                        result += 1
                    }
                }
                
                results.append(result)
            }
        }
        
        let sorted = results.sorted{ $0 > $1 }
        
        return sorted.first ?? 0
    }
}
```

## Tests

```swift
class Problem_249Tests: XCTestCase {

    func test_xOrCount() {
        
        let input = [0, 1, 2, 3, 4]
        
        let actual = input.xOrCount()
        let expected = 0
        
        XCTAssert(actual == expected)
    }
    
    func test_xOrCount_2() {
        
        let input = [0, 1, 1, 1, 1]
        
        let actual = input.xOrCount()
        let expected = 3
        
        print(actual)
        XCTAssert(actual == expected)
    }

}
```