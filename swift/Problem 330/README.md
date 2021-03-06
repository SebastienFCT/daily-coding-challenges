## Description

This problem was asked by Dropbox.

A Boolean formula can be said to be satisfiable if there is a way to assign truth values to each variable such that the entire formula evaluates to true.

For example, suppose we have the following formula, where the symbol `¬` is used to denote negation:

```
(¬c OR b) AND (b OR c) AND (¬b OR c) AND (¬c OR ¬a)
```

One way to satisfy this formula would be to let `a = False`, `b = True`, and `c = True`.

This type of formula, with AND statements joining tuples containing exactly one OR, is known as 2-CNF.

Given a `2-CNF` formula, find a way to assign truth values to satisfy it, or return False if this is impossible.

## Solution

```swift
extension String {
    
    func solve2Cnf() -> [Character: Bool]? {
        
        var result: [Character: Bool] = [:]
        
        var variables: [Character] = []
        
        var copy = self
        copy = copy.replacingOccurrences(of: "¬", with: "!")
        copy = copy.replacingOccurrences(of: "AND", with: "&")
        copy = copy.replacingOccurrences(of: "OR", with: "|")
        
        for character in copy {
            if character == " " || character == "(" || character == ")" || character == "&" || character == "|" || character == "!" {
                continue
            }
            
            if !variables.contains(character) {
                variables.append(character)
            }
        }
        
        let map = Array(repeating: true, count: variables.count)
        
        for candidate in allBoolCombinations(current: [], remaining: map.count) {
            
            var attempt = copy
            
            for i in 0..<variables.count {
                attempt = attempt.replacingOccurrences(of: String(variables[i]), with: candidate[i] ? "true" : "false")
                result[variables[i]] = candidate[i]
            }
            
            attempt = attempt.replacingOccurrences(of: "!true", with: "false")
            attempt = attempt.replacingOccurrences(of: "!false", with: "true")
            
            let expression = NSExpression(format: attempt)
            if let evaluation = expression.expressionValue(with: nil, context: nil) as? NSNumber, evaluation.boolValue {

                return result
            }
            
            
        }
        
        return nil
    }
}

func allBoolCombinations(current: [Bool], remaining: Int) -> [[Bool]] {
    
    if remaining == 1 {
        var copy1 = current
        copy1.append(true)
        
        var copy2 = current
        copy2.append(false)
        
        var result: [[Bool]] = []
        result.append(copy1)
        result.append(copy2)
        
        return result
    }
    
    var result: [[Bool]] = []
    var copy = current
    copy.append(true)
    
    result.append(contentsOf: allBoolCombinations(current: copy, remaining: remaining-1))
    
    copy = current
    copy.append(false)
    
    result.append(contentsOf: allBoolCombinations(current: copy, remaining: remaining-1))
    
    return result
}
```

## Tests

```swift
class Problem_330Tests: XCTestCase {

    func test_example() {
        
        let actual = "(¬c OR b) AND (b OR c) AND (¬b OR c) AND (¬c OR ¬a)".solve2Cnf()
        let expected: [Character: Bool] = ["c": true, "a": false, "b": true]
        
        XCTAssert(actual == expected)
    }

}
```