## Description

This problem was asked by Facebook.

Given a string of parentheses, find the balanced string that can be produced from it using the minimum number of insertions and deletions. If there are multiple solutions, return any of them.

For example, given "(()", you could return "(())". Given "))()(", you could return "()()()()".


## Solution

```swift
extension String {
    
    func closerBalancedParentheses() -> String {
        
        let filtered = self.filter{ $0 != "(" && $0 != ")" }
        
        guard filtered.count == 0  else {
            fatalError("`closerBalancedParentheses` must only contains parentheses")
        }
        
        let result = nextParentheses(currentModifications: 0)
        
        return result.result
        
    }
    
    private func nextParentheses(currentModifications: Int) -> (result: String, modifications: Int) {
        
        var copy = self
        
        var openedParentheses = 0
        
        var index = 0
        for character in copy {
            if character == "(" {
                openedParentheses += 1
            } else {
                openedParentheses -= 1
            }
            
            if openedParentheses < 0 {
                let stringIndex = copy.index(startIndex, offsetBy: index)
                copy.insert("(", at: stringIndex)
                
                return copy.nextParentheses(currentModifications: currentModifications + 1)
            }
            
            index += 1
        }
        
        if openedParentheses > 0 {
            for _ in 1...openedParentheses {
                copy.insert(")", at: copy.endIndex)
            }
            
            return copy.nextParentheses(currentModifications: currentModifications + openedParentheses)
        }
        
        return (copy, currentModifications)
    }
}
```

## Test

```swift
class Problem_199Tests: XCTestCase {

    func test_example_1() {
        XCTAssert("(()".closerBalancedParentheses() == "(())")
    }
    
    func test_example_2() {
        XCTAssert("))()(".closerBalancedParentheses() == "()()()()")
    }

}
```