## Description

This problem was asked by Yahoo.

You are given a string of length `N` and a parameter `k`. The string can be manipulated by taking one of the first `k` letters and moving it to the end.

Write a program to determine the lexicographically smallest string that can be created after an unlimited number of moves.

For example, suppose we are given the string daily and `k = 1`. The best we can create in this case is ailyd.

## Solution

```swift
extension String {
    
    func lexicoMin(movingAnyOfTheFirsts: Int) -> String {
        
        let sortedValue = sorted()
        
        if movingAnyOfTheFirsts > 1 {
            return String(sortedValue)
        }
        
        guard let firstCharacter = sortedValue.first else {
            return ""
        }
        
        var indexesAndWords: [Int: String] = [:]
        
        for i in 0..<count {
            if self[i] == firstCharacter {
                
                var value = ""
                for j in i..<count {
                    value = "\(value)\(self[j])"
                }
                
                for j in 0..<i {
                    value = "\(value)\(self[j])"
                }
                
                indexesAndWords[i] = value
            }
        }
        
        let candidates = indexesAndWords.map({ $0.value })
        let sorted = candidates.sorted{ $0 < $1 }
        
        return sorted.first ?? ""
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}
```

## Tests

```swift
class Problem_347Tests: XCTestCase {

    func test_example() {
        
        let input = "daily"
        let actual = input.lexicoMin(movingAnyOfTheFirsts: 1)
        let expected = "ailyd"
        
        XCTAssert(actual == expected)
    }

}
```