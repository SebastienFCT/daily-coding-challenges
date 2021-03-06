## Description

This problem was asked by Slack.

You are given a string formed by concatenating several words corresponding to the integers zero through nine and then anagramming.

For example, the input could be 'niesevehrtfeev', which is an anagram of 'threefiveseven'. Note that there can be multiple instances of each integer.

Given this string, return the original integers in sorted order. In the example above, this would be `357`.

## Solution

```swift
struct NumFinder {
    
    var numWords: [String: Int] = [
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    ]
    
    func solve(word: String) -> Int {
        
        var rep = word.charRepartition()
        var values: [Int] = []
        
        for (numWord, num) in numWords {
            
            let numWordRep = numWord.charRepartition()
            
            var iterate = true
            while iterate {
                
                if let next = rep.contains(dict: numWordRep) {
                    rep = next
                    values.append(num)
                } else {
                    iterate = false
                }
            }
            
        }
        
        values.sort()
        var result = 0
        var multiplier = 1
        
        for i in stride(from: values.count-1, through: 0, by: -1) {
            result += values[i] * multiplier
            multiplier *= 10
        }
        
        return result
    }
}

extension String {
    
    func charRepartition() -> [Character: Int] {
        
        var result: [Character: Int] = [:]
        
        for char in self {
            if result.keys.contains(char) {
                result[char]! += 1
            } else {
                result[char] = 1
            }
        }
        
        return result
    }
}

extension Dictionary where Key == Character, Value == Int {
    
    func contains(dict: [Character: Int]) -> [Character: Int]? {
        
        var copy = self
        
        for (key, value) in dict {
            
            if copy.keys.contains(key) {
                if copy[key]! >= value {
                    copy[key]! -= value
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        
        return copy
    }
}
```

## Tests

```swift
class Problem_359Tests: XCTestCase {

    func test_example() {
        
        let input = "niesevehrtfeev"
        let numFinder = NumFinder()
        
        let actual = numFinder.solve(word: input)
        let expected = 357
        
        XCTAssert(actual == expected)
    }

}
```