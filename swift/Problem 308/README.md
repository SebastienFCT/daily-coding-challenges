## Description

This problem was asked by Quantcast.

You are presented with an array representing a Boolean expression. The elements are of two kinds:

- `T` and `F`, representing the values `True` and `False`.
- `&`, |`,` and `^`, representing the bitwise operators for `AND`, `OR`, and `XOR`.

Determine the number of ways to group the array elements using parentheses so that the entire expression evaluates to `True`.

For example, suppose the input is `['F', '|', 'T', '&', 'T']`. In this case, there are two acceptable groupings: `(F | T)` & `T` and `F | (T & T)`.

## Solution

```swift
struct Quantcast {
    
    var expression: [Character]
    
    func countForTrueResult() -> Int {
        
        guard (expression.filter{ !["F", "T", "&", "|", "^"].contains($0) }.isEmpty) else {
            fatalError("Invalid input")
        }
        
        guard !expression.isEmpty else {
            return 0
        }
        
        var copy = expression
        let character = copy.removeLast()
        
        switch character {
        case "T":
            return count(input: copy, current: true)
        case "F":
            return count(input: copy, current: false)
        default:
            fatalError("Cannot be evaluated")
        }
    }
    
    private func count(input: [Character], current: Bool) -> Int {
        
        if input.isEmpty {
            if current {
                return 1
            }
        }
        
        guard input.count >= 2 else {
            fatalError("Cannot be evaluated")
        }
        
        var result = 0
        
        // case 1: wrap the the last expression
        var copy = input
        let symbol = copy.removeLast()
        
        guard (["&", "|", "^"].contains(symbol)) else {
            fatalError("Cannot be evaluated")
        }
        
        let character = copy.removeLast()
        result += count(input: copy, current: evaluate(left: character, right: current ? "T" : "F", symbol: symbol))
        
        // case 2: wrap the 2 previous instead
        if input.count >= 4 {
            
            copy = input
            let symbolToKeep = copy.removeLast()
            
            let right = copy.removeLast()
            let symbol = copy.removeLast()
            let left = copy.removeLast()
            
            copy.append(evaluate(left: left, right: right, symbol: symbol) ? "T" : "F")
            copy.append(symbolToKeep)
            
            result += count(input: copy, current: current)
        }
        
        return result
    }
    
    private func evaluate(left: Character, right: Character, symbol: Character) -> Bool {
        
        switch symbol {
        case "&":
            return (left == "T" && right == "T") || (left == "F" && right == "F")
        case "|":
            return left == "T" || right == "T"
        case "^":
            return (left == "T" && right == "F") || (left == "F" && right == "T")
        default:
            fatalError("symbol \(symbol) not handled.")
        }
    }
}
```

## Tests

```swift
class Problem_308Tests: XCTestCase {

    func test_example() {
        
        let expression: [Character] = ["F", "|", "T", "&", "T"]
        let input = Quantcast(expression: expression)
        
        let actual = input.countForTrueResult()
        let expected = 2
        
        XCTAssert(actual == expected)
    }

}
```