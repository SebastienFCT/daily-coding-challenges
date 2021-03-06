## Description

This problem was asked by Yext.

Two nodes in a binary tree can be called cousins if they are on the same level of the tree but have different parents. For example, in the following diagram 4 and 6 are cousins.

```
    1
   / \
  2   3
 / \   \
4   5   6
```

Given a binary tree and a particular node, find all cousins of that node.

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
    
    func nodesByLevel() -> [[Node]] {
    
        var result: [[Node]] = []
        
        var current: [Node] = []
        
        if let left = left {
            current.append(left)
        }
        
        if let right = right {
            current.append(right)
        }
        
        result.append(current)
        
        return result
    }
}

struct BinaryTree {
    
    var root: Node
    var nodesByLevel: [Int: [Node]]
    
    func cousin(of node: Node) -> [Node] {
        
        var result: [Node] = []
        var resultKey = 0
        
        // For simplicity we assume that nodes are unique in values
        for key in nodesByLevel.keys {
            if nodesByLevel[key]!.contains(where: { (aNode) -> Bool in
                aNode.value == node.value
            }) {
                result = nodesByLevel[key]!
                resultKey = key
                break
            }
        }
        
        var toRemove: Int? = nil
        
        if resultKey > 0 && result.count > 1 {
            for aNode in nodesByLevel[resultKey-1]! {
                if aNode.left?.value == node.value {
                    if let right = aNode.right {
                        toRemove = right.value
                        break
                    }
                }
                
                if aNode.right?.value == node.value {
                    if let left = aNode.left {
                        toRemove = left.value
                        break
                    }
                }
            }
        }
        
        if let toRemove = toRemove {
            for i in 0..<result.count {
                if result[i].value == toRemove {
                    result.remove(at: i)
                    break
                }
            }
        }
        
        for i in 0..<result.count {
            if result[i].value == node.value {
                result.remove(at: i)
                break
            }
        }
        
        return result
    }
    
    // New coding approach with a struct holding the binary tree and a function building the levels
    // After looking at the implementation it's not really easier to read and not worth it in terms of implementation since it does much more than just retrieving what it needs
    mutating func buildNodesByLevel() {
        nodesByLevel = [:]
        
        nodesByLevel[0] = [root]
        
        var currentLevel = 0
        
        while true {
            
            if !nodesByLevel.keys.contains(currentLevel) {
                return
            }
            
            if nodesByLevel[currentLevel]!.isEmpty {
                return
            }
            
            for node in nodesByLevel[currentLevel]! {
                
                if let left = node.left {
                    if !nodesByLevel.keys.contains(currentLevel+1) {
                        nodesByLevel[currentLevel+1] = [left]
                    } else {
                        nodesByLevel[currentLevel+1]!.append(left)
                    }
                }
                
                if let right = node.right {
                    if !nodesByLevel.keys.contains(currentLevel+1) {
                        nodesByLevel[currentLevel+1] = [right]
                    } else {
                        nodesByLevel[currentLevel+1]!.append(right)
                    }
                }
            }
            
            currentLevel += 1
        }
    }
}
```

## Tests

```swift
class Problem_284Tests: XCTestCase {

    func test_example() {
        
        let root = Node(value: 1)
        let l = Node(value: 2)
        let r = Node(value: 3)
        let ll = Node(value: 4)
        let lr = Node(value: 5)
        let rr = Node(value: 6)
        
        r.right = rr
        
        l.left = ll
        l.right = lr
        
        root.left = l
        root.right = r
        
        var bt = BinaryTree(root: root, nodesByLevel: [:])
        bt.buildNodesByLevel()
        
        let actual = bt.cousin(of: ll).map{ $0.value }
        let expected = [6]
        
        XCTAssert(actual == expected)
    }

}
```