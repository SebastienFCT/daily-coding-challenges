## Description

This problem was asked by Etsy.

Given a sorted array, convert it into a height-balanced binary search tree.

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
    
    func toString() -> String {
        
        var result = "\(value)"
        
        if let left = left {
            result = "\(result) -> \(left.toString())"
        }
        
        if let right = right {
            result = "\(result) -> \(right.toString())"
        }
        
        return result
    }
}

extension Array where Element == Int {
    
    func heightBalancedBinaryTree() -> Node {
        
        if count == 1 {
            return Node(value: self.first!)
        }
        
        if count == 2 {
            return Node(value: last!, left: Node(value: first!), right: nil)
        }
        
        let sorted = self.sorted{ $0 < $1 }
        
        let center = sorted[sorted.count / 2]
        let node = Node(value: center)
        
        if count % 2 == 0 {
            node.left = Array(prefix((sorted.count / 2) - 1)).heightBalancedBinaryTree()
            node.right = Array(suffix((sorted.count / 2) - 1)).heightBalancedBinaryTree()
        } else {
            node.left = Array(prefix((sorted.count / 2))).heightBalancedBinaryTree()
            node.right = Array(suffix((sorted.count / 2))).heightBalancedBinaryTree()
        }
        
        return node
    }
}
```

## Tests

```swift
class Problem_296Tests: XCTestCase {

    func test_height_balanced_binary_tree_builder() {
        
        let input = [1, 2, 3, 4, 5, 6]
        XCTAssert(input.heightBalancedBinaryTree().toString() == "4 -> 2 -> 1 -> 6 -> 5")
        
        let input2 = [1, 2, 3, 4, 5, 6, 7]
        XCTAssert(input2.heightBalancedBinaryTree().toString() == "4 -> 2 -> 1 -> 3 -> 6 -> 5 -> 7")
    }

}
```