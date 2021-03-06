## Description

This problem was asked by Airbnb.

Given a list of words, find all pairs of unique indices such that the concatenation of the two words is a palindrome.

For example, given the list `["code", "edoc", "da", "d"]`, return `[(0, 1), (1, 0), (2, 3)]`.

## Solution

```swift
extension Array where Element == String {
    
    func pairsThatBuildPalindrome() -> [(leftIndex: Int, rightIndex: Int)] {
        
        var result: [(leftIndex: Int, rightIndex: Int)] = []
        
        for i in 0..<count {
            
            let leftElement = self[i]
            
            for j in 0..<count {
                
                if i == j { continue }
                
                let rightElement = self[j]
                
                let compoundElement = "\(leftElement)\(rightElement)"
                
                if compoundElement.isPalindrome() {
                    result.append((i, j))
                }
            }
        }
        
        return result
    }
    
    
}

extension String {
    
    func isPalindrome() -> Bool {
        
        let left = self.prefix(count / 2)
        let right = self.suffix(count / 2)
        
        return Array(left) == right.reversed()
    }
}
```

## Test

```swift
class Problem_167Tests: XCTestCase {

    func test_example() {
        let result = ["code", "edoc", "da", "d"].pairsThatBuildPalindrome()
        
        XCTAssert(result.count == 3)
        XCTAssert(result.contains(where: { (element) -> Bool in
            element.leftIndex == 0 && element.rightIndex == 1
            ||
            element.leftIndex == 1 && element.rightIndex == 0
            ||
            element.leftIndex == 2 && element.rightIndex == 3
        }))
    }

}
```