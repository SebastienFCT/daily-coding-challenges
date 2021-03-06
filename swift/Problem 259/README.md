## Description

This problem was asked by Two Sigma.

Ghost is a two-person word game where players alternate appending letters to a word. The first person who spells out a word, or creates a prefix for which there is no possible continuation, loses. Here is a sample game:

```
Player 1: g
Player 2: h
Player 1: o
Player 2: s
Player 1: t [loses]
```

Given a dictionary of words, determine the letters the first player should start with, such that with optimal play they cannot lose.

For example, if the dictionary is `["cat", "calf", "dog", "bear"]`, the only winning start letter would be `b`.

## Solution

```swift
extension Array where Element == String {
    
    func optimalStartForGhost() -> String? {
        
        let letters = self.map{ String($0.prefix(1)) }
        let uniqueLetters = Array(Set(letters))
        
        for letter in uniqueLetters {
            if !isWinningGhost(current: letter) {
                return letter
            }
        }
        
        return nil
    }
    
    func isWinningGhost(current: String) -> Bool {
        
        let sorted = self.filter{ $0.count >= current.count && String($0.prefix(current.count)) == current }
        let mapped = sorted.map{ $0.count }.filter{ $0 > current.count }
        
        if mapped.isEmpty {
            // this means that the current word actually reached a full word from the dictionary or reached a prefix that won't match any word
            return true
        }
        
        if !mapped.isEmpty {
            
            // if any of this condition leads optimally to the other user loosing, then it's a win
            for item in sorted {
                
                if (!isWinningGhost(current: String(item.prefix(current.count + 1)))) {
                    return true
                }
            }
        }
        
        // ortherwise it's a loose
        return false
    }
}
```

## Tests

```swift
class Problem_259Tests: XCTestCase {

    func test_example() {
        
        let input = ["cat", "calf", "dog", "bear"]
        let expected = "b"
        let actual = input.optimalStartForGhost()
        
        XCTAssert(actual == expected)
    }

}
```