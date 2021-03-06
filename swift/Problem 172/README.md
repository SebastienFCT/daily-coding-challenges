## Description

This problem was asked by Dropbox.

Given a string `s` and a list of words `words`, where each word is the same length, find all starting indices of substrings in `s` that is a concatenation of every word in `words` exactly once.

For example, given s = "dogcatcatcodecatdog" and words = ["cat", "dog"], return [0, 13], since "dogcat" starts at index 0 and "catdog" starts at index 13.

Given s = "barfoobazbitbyte" and words = ["dog", "cat"], return [] since there are no substrings composed of "dog" and "cat" in `s`.

The order of the indices does not matter.

## Solution

```swift
extension Array where Element == String {
    
    func indicesForCombinations(s: String) -> [Int] {
        var result: [Int] = []
        
        let combinations = allCombinations(previous: [])
        
        for word in combinations {
            if s.contains(word) {
                if let range = s.indexOf(substring: word) {
                    result.append(range.lowerBound)
                }
            }
        }
        
        return result
    }
    
    private func allCombinations(previous: [String]) -> [String] {
        var result: [String] = []
        
        if isEmpty {
            return previous
        }
        
        if previous.isEmpty {
            for i in 0..<count {
                let word = self[i]
                
                var newArray: [String] = []
                newArray.append(word)
                
                var remaining: [String] = []
                remaining.append(contentsOf: self.prefix(i))
                remaining.append(contentsOf: self.suffix(count-i-1))
                
                result.append(contentsOf: remaining.allCombinations(previous: newArray))
            }
        } else {
            for existing in previous {
                for i in 0..<count {
                    var copy = existing
                    copy += "\(self[i])"
                    
                    var newArray: [String] = []
                    newArray.append(copy)
                    
                    var remaining: [String] = []
                    remaining.append(contentsOf: self.prefix(i))
                    remaining.append(contentsOf: self.suffix(count-i-1))
                    
                    result.append(contentsOf: remaining.allCombinations(previous: newArray))
                }
            }
        }
        
        return result
    }
}

extension String {
    func indexOf(substring: String) -> NSRange? {
        if let range = range(of: substring) {
            let startPos = distance(from: startIndex, to: range.lowerBound)
            return NSMakeRange(startPos, substring.count)
        }
        
        return nil
    }
}
```

## Test

```swift
class Problem_172Tests: XCTestCase {

    func test_example() {
        XCTAssert(["cat", "dog"].indicesForCombinations(s: "dogcatcatcodecatdog") == [13, 0])
        
        XCTAssert(["cat", "dog"].indicesForCombinations(s: "barfoobazbitbyte") == [])
    }

}
```