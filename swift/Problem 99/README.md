## Description

This problem was asked by Microsoft.

Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

For example, given `[100, 4, 200, 1, 3, 2]`, the longest consecutive element sequence is `[1, 2, 3, 4]`. Return its length: `4`.

Your algorithm should run in `O(n)` complexity.

## Solution

```swift
extension Array where Element == Int {
    func longestConsecutiveSubsequence() -> Int {
        
        var copy = self.sorted{ $0 < $1 }
        var references: [Int : Int] = [:]
        
        for i in 0..<count {
            if references[copy[i]-1] != nil {
                let val = references[copy[i]-1]!
                references.removeValue(forKey: copy[i]-1)
                references[copy[i]] = val + 1
            } else {
                references[copy[i]] = 1
            }
        }
        
        return references.values.sorted{ $0 > $1 }.first ?? 0
    }
}
```

## Test

```swift
class Problem_99Tests: XCTestCase {

    func test_example() {
        let input = [100, 4, 200, 1, 3, 2]
        print(input.longestConsecutiveSubsequence())
    }

}
```