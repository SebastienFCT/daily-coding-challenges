## Description

This problem was asked by Google.

Given a word `W` and a string `S`, find all starting indices in `S` which are anagrams of `W`.

For example, given that `W` is "ab", and `S` is "abxaba", return 0, 3, and 4.

## Solution

```swift
extension String {
    func indexesForAnagrams(of value: String) -> [Int] {
        var result: [Int] = []
        
        for i in 0..<count {
            let current = String(self.suffix(count-i).prefix(value.count))
            
            if current.count != value.count {
                continue
            }
            
            if (current.sorted{ $0 < $1} == value.sorted{ $0 < $1 }) {
                result.append(i)
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_111Tests: XCTestCase {

    func test_example() {
        XCTAssert("abxaba".indexesForAnagrams(of: "ab") == [0, 3, 4])
    }

}
```