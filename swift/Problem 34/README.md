## Description

This problem was asked by Quora.

Given a string, find the palindrome that can be made by inserting the fewest number of characters as possible anywhere in the word. If there is more than one palindrome of minimum length that can be made, return the lexicographically earliest one (the first one alphabetically).

For example, given the string `race`, you should return `ecarace`, since we can add three letters to it (which is the smallest amount to make a palindrome). There are seven other palindromes that can be made from `race` by adding three letters, but `ecarace` comes first alphabetically.

As another example, given the string "google", you should return `elgoogle`.

## Solution


```swift
extension String {
    func isPalindrome() -> Bool {
        
        let mid = self.count / 2
        
        return String(self.prefix(mid)) == String(self.suffix(mid).reversed())
    }
    
    func findLargestPartWithSymetry() -> [(String, Int)] {
        var copy = self
        var reversed = String(self.reversed())
        var index = 0
        
        while !copy.isEmpty {
            if copy.isPalindrome() && reversed.isPalindrome() {
                return [(copy, index), (reversed, 0)]
            }
            
            if copy.isPalindrome() {
                return [(copy, index)]
            }
            
            if reversed.isPalindrome() {
                return [(reversed, 0)]
            }
            
            _ = copy.removeFirst()
            _ = reversed.removeFirst()
            index += 1
        }
        
        return []
    }
    
    func findPalindrome() -> String {
        let candidates = self.findLargestPartWithSymetry()
        
        return candidates.map{ buildPalindrome(base: self, part: $0) }.sorted{ $0 < $1 }.first ?? ""
    }
}

func buildPalindrome(base: String, part: (value: String, index: Int)) -> String {
    var result = base
    if part.index == 0 {
        let boundary = part.value.count % 2 == 0 ? part.value.count - 1 : part.value.count
        for i in boundary..<base.count {
            result.insert(base[base.index(base.startIndex, offsetBy: i)], at: result.startIndex)
        }
    } else {
        var i = part.index
        while i >= 0 {
            result.insert(base[base.index(base.startIndex, offsetBy: i)], at: result.endIndex)
            i -= 1
        }
    }
    
    return result
}
```

## Tests

```swift
class Problem_34Tests: XCTestCase {
    
    func test_1() {
        let input = "BOB"
        XCTAssertTrue(input.isPalindrome())
    }
    
    func test_2() {
        let input = "alasaka"
        print(input.findLargestPartWithSymetry())
    }
    
    func test_3() {
        let input = "race"
        XCTAssert(buildPalindrome(base: input, part: ("ra", 0)) == "ecarace")
        
        let input2 = "race"
        XCTAssert(buildPalindrome(base: input2, part: ("ce", 2)) == "racecar")
    }
    
    func test_4() {
        let input = "race"
        XCTAssert(input.findPalindrome() == "ecarace")
    }
    
    func test_5() {
        let input = "alasaka"
        XCTAssert(input.findPalindrome() == "akasalasaka")
    }
}
```