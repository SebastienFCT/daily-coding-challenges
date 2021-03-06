## Description

This problem was asked by Facebook.

Given a binary tree, return the level of the tree with minimum sum.

## Solution

```swift
class Node {
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    typealias NodeLevelAndSum = (level: Int, sum: Int)
    
    func minimumSum(currentLevel: Int, currentSum: Int) -> NodeLevelAndSum {
        
        var candidates: [NodeLevelAndSum] = [(level: currentLevel, sum: currentSum)]
        
        if let left = left {
            candidates.append(left.minimumSum(currentLevel: currentLevel + 1, currentSum: currentSum + left.value))
        }
        
        if let right = right {
            candidates.append(right.minimumSum(currentLevel: currentLevel + 1, currentSum: currentSum + right.value))
        }
        
        return candidates.sorted{ $0.sum < $1.sum }.first!
    }
}
```

## Test

```swift
class Problem_117Tests: XCTestCase {

    func test_node_minimum_sum() {
        let root = Node(value: 0)
        let l = Node(value: -1)
        let ll = Node(value: 10)
        let lr = Node(value: -5)
        let r = Node(value: 2)
        let rl = Node(value: 1)
        let rr = Node(value: -2)
        
        root.left = l
        root.right = r
        
        l.left = ll
        l.right = lr
        
        r.left = rl
        r.right = rr
        
        XCTAssert(root.minimumSum(currentLevel: 0, currentSum: root.value) == (level: 2, sum: -6))
    }

}
```