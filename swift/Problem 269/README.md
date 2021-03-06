## Description

This problem was asked by Microsoft.

You are given an string representing the initial conditions of some dominoes. Each element can take one of three values:

- `L`, meaning the domino has just been pushed to the left,
- `R`, meaning the domino has just been pushed to the right, or
- `.`, meaning the domino is standing still.

Determine the orientation of each tile when the dominoes stop falling. Note that if a domino receives a force from the left and right side simultaneously, it will remain upright.

For example, given the string `.L.R....L`, you should return `LL.RRRLLL`.

Given the string `..R...L.L`, you should return `..RR.LLLL`.


## Solution

```swift
extension Array where Element == Character {
    
    func dominos() -> [Character] {
        
        guard (filter{ $0 == "." && $0 == "L" && $0 == "R" }.count == 0) else {
            fatalError("Invalid input")
        }
        
        var result = self
        var changeCount = 0
        
        for i in 0..<count {
            
            let current = self[i]
            
            if current != "." { continue }
            
            if (i == 0 && self[i+1] == "." || i == 0 && self[i+1] == "R") { continue }
            
            if (i == count-1 && self[i-1] == "." || i == count-1 && self[i-1] == "L") { continue }
            
            if (i == 0 && self[i+1] == "L") {
                result[i] = "L"
                changeCount += 1
                continue
            }
            
            if (i == count-1 && self[i-1] == "R") {
                result[i] = "R"
                changeCount += 1
                continue
            }
            
            switch (self[i-1], self[i+1]) {
                case ("L", "L"):
                    result[i] = "L"
                    changeCount += 1
                    continue
                case ("R", "R"):
                    result[i] = "R"
                    changeCount += 1
                    continue
                case ("R", "."):
                    result[i] = "R"
                    changeCount += 1
                    continue
                case (".", "L"):
                    result[i] = "L"
                    changeCount += 1
                    continue
                default:
                    continue
            }
            
        }
        
        return changeCount == 0 ? result : result.dominos()
    }
}
```

## Tests

```swift
class Problem_269Tests: XCTestCase {

    func test_example_1() {
        let input: [Character] = [".", "L", ".", "R", ".", ".", ".", ".", "L"]
        let expected: [Character] = ["L", "L", ".", "R", "R", "R", "L", "L", "L"]
        let actual = input.dominos()
        
        XCTAssert(actual == expected)
    }
    
    func test_example_2() {
        let input: [Character] = [".", ".", "R", ".", ".", ".", "L", ".", "L"]
        let expected: [Character] = [".", ".", "R", "R", ".", "L", "L", "L", "L"]
        let actual = input.dominos()
        
        XCTAssert(actual == expected)
    }

}
```