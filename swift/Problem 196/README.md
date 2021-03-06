## Description

This problem was asked by Apple.

Given the root of a binary tree, find the most frequent subtree sum. The subtree sum of a node is the sum of all values under a node, including the node itself.

For example, given the following tree:

```
  5
 / \
2  -5
```

Return 2 as it occurs twice: once as the left leaf, and once as the sum of `2 + 5 - 5`.

## Solution

```swift
class Node {
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int, left: Node?, right: Node?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    func mostFrequentSubtreeSum() -> Int {
        
        let candidates = subTreeSums()
        
        var result = 0
        var count = 0
        
        for key in candidates.keys {
            if candidates[key]! > count {
                count = candidates[key]!
                result = key
            }
        }
        
        return result
    }
    
    func subTreeSums() -> [Int: Int] {
        
        var result: [Int: Int] = [:]
        
        let currentSum = sum()
        
        if result.keys.contains(currentSum) {
            result[currentSum]! += 1
        } else {
            result[currentSum] = 1
        }
        
        if let left = left {
            let leftResults = left.subTreeSums()
            
            for key in leftResults.keys {
                if result.keys.contains(key) {
                    result[key]! += leftResults[key]!
                } else {
                    result[key] = leftResults[key]!
                }
            }
        }
        
        if let right = right {
            let rightResults = right.subTreeSums()
            
            for key in rightResults.keys {
                if result.keys.contains(key) {
                    result[key]! += rightResults[key]!
                } else {
                    result[key] = rightResults[key]!
                }
            }
        }
        
        return result
    }
    
    func sum() -> Int {
        
        var result = value
        
        if let left = left {
            result += left.sum()
        }
        
        if let right = right {
            result += right.sum()
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_196Tests: XCTestCase {

    func test_example() {
        let tree = Node(value: 5, left: Node(value: 2), right: Node(value: -5))
        
        XCTAssert(tree.mostFrequentSubtreeSum() == 2)
    }

}
```