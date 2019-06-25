## Description

This problem was asked by Facebook.

Given a string of round, curly, and square open and closing brackets, return whether the brackets are balanced (well-formed).

For example, given the string `([])[]({})`, you should return true.

Given the string `([)]` or `((()`, you should return false.

## Solution

My first though was to build a function that splits the array into to arrays of equal length and check that they are symetric, something like:

```swift
extension String {
    func isWellFormed() -> Bool {
        if self.count % 2 != 0 {
            // can't be divided into two arrays of the same length
            return false
        }
        
        var left = String(self.prefix(self.count / 2))
        var right = String(self.suffix(self.count / 2))
        
        while !left.isEmpty {
            if let leftFirst = left.first, let rightLast = right.last {
                if leftFirst != rightLast {
                    return false
                }
                
                left = String(left.dropFirst())
                right = String(right.dropLast())
            }
        }
        
        return true
    }
}
```

However, I quickly realize that this doesn't work for the example: `([])[]({})` (see test1)
 
Well formed isn't defined by symetry.

A simple way to define it is : "Every opening bracket has its closing bracket"

Let's write a function that does this, it scans the characters, if it's an opening bracket it stores it in an array of opening brackend, if it's a closing one, it checks that it matches the last opening one in the array and continue

```swift
extension String {
    mutating func isWellFormed2() -> Bool {
        var openingBrackets: [Character] = []
        
        while !self.isEmpty {
            if let character = self.first {
                if character == "{" || character == "(" || character == "[" {
                    openingBrackets.append(character)
                }
                
                if character == "}" {
                    if let lastBracket = openingBrackets.last {
                        if lastBracket != "{" {
                            return false
                        }
                        
                        _ = openingBrackets.removeLast()
                    }
                }
                
                if character == ")" {
                    if let lastBracket = openingBrackets.last {
                        if lastBracket != "(" {
                            return false
                        }
                        
                        _ = openingBrackets.removeLast()
                    }
                }
                
                if character == "]" {
                    if let lastBracket = openingBrackets.last {
                        if lastBracket != "[" {
                            return false
                        }
                        
                        _ = openingBrackets.removeLast()
                    }
                }
            }
            
            self = String(self.dropFirst())
        }
        
        if !openingBrackets.isEmpty {
            // some opening brackets didn't close
            return false
        }
        
        return true
    }
}
```

Great, that worked.
 
However, it's annoying to see all this redoundant code... What if the requirements are changing and we want to be able to handle "<" and ">" or other set of characters?

First, we need a structure that holds pairs of characters and is able to check if any two characters provided are matching each other

```swift
struct Pairs {
    var sets: [Pair]
    
    func matches(lhs: Character, rhs: Character) -> Bool {
        return sets.contains(where: { (pair) -> Bool in
            (pair.left == lhs && pair.right == rhs)
        })
    }
    
    func isOpeningCharacter(_ character: Character) -> Bool {
        for set in sets {
            if set.left == character {
                return true
            }
        }
        
        return false
    }
    
    func isClosingCharacter(_ character: Character) -> Bool {
        for set in sets {
            if set.right == character {
                return true
            }
        }
        
        return false
    }
}

struct Pair {
    var left: Character
    var right: Character
}
```

Finally, let's re-write our function using this new struct

```swift
extension String {
    mutating func isWellFormed3(forPairs pairs: Pairs) -> Bool {
        var openingBrackets: [Character] = []
        
        while !self.isEmpty {
            if let next = self.first {
                if pairs.isOpeningCharacter(next) {
                    openingBrackets.append(next)
                }
                
                if pairs.isClosingCharacter(next), let lastOpening = openingBrackets.last {
                    if pairs.matches(lhs: lastOpening, rhs: next) {
                        _ = openingBrackets.removeLast()
                    } else {
                        return false
                    }
                }
                
                self = String(self.dropFirst())
            }
        }
        
        if !openingBrackets.isEmpty {
            // some opening brackets didn't close
            return false
        }
        
        return true
    }
}
```

## Tests

```swift
class Problem_27Tests: XCTestCase {

    func test_1() {
        let input = "([])[]({})"
        XCTAssertTrue(input.isWellFormed())
    }
    
    func test_2() {
        var input = "([])[]({})"
        XCTAssertTrue(input.isWellFormed2())
    }
    
    func test_3() {
        let pairs = Pairs(sets: [Pair(left: "{", right: "}"), Pair(left: "[", right: "]"), Pair(left: "(", right: ")")])
        
        var input = "([])[]({})"
        XCTAssertTrue(input.isWellFormed3(forPairs: pairs))
    }

}
```