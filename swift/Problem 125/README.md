## Description

This problem was asked by Google.

Given the root of a binary search tree, and a target `K`, return two nodes in the tree whose sum equals `K`.

For example, given the following tree and `K` of `20`

```
    10
   /   \
 5      15
       /  \
     11    15
```

Return the nodes `5` and `15`.

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
    
    func paidForSum(_ sum: Int) -> [Node]? {
        
        let nodes = allNodes()
        
        for i in 0..<nodes.count {
            let current = nodes[i]
            
            for j in i+1..<nodes.count {
                let other = nodes[j]
                
                if current.value + other.value == sum {
                    return [current, other]
                }
            }
        }
        
        return nil
    }
    
    func allNodes() -> [Node] {
        
        var result: [Node] = []
        result.append(self)
        
        if let left = left {
            result.append(contentsOf: left.allNodes())
        }
        
        if let right = right {
            result.append(contentsOf: right.allNodes())
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_125Tests: XCTestCase {

    func test_example() {
        let root = Node(value: 10)
        let l = Node(value: 5)
        let r = Node(value: 15)
        let rl = Node(value: 11)
        let rr = Node(value: 15)
        
        root.left = l
        root.right = r
        
        r.left = rl
        r.right = rr
        
        let current = root.paidForSum(20)
        XCTAssert(current?.count == 2)
        XCTAssert(current![0].value + current![1].value == 20)
    }

}
```