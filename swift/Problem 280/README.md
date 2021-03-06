## Description

This problem was asked by Pandora.

Given an undirected graph, determine if it contains a cycle.


## Solution

```swift
class Node {
    var value: Int
    var nodes: [Node]
    
    init(value: Int, nodes: [Node]) {
        self.value = value
        self.nodes = nodes
    }
    
    init(value: Int) {
        self.value = value
        self.nodes = []
    }
    
    func containsCycle(current: [Node]) -> Bool {
        
        var result = current
        
        if result.contains(where: { (aNode) -> Bool in
            aNode.value == value
        }) {
            return true
        } else {
            result.append(self)
        }
        
        for node in nodes {
            
            if node.containsCycle(current: result) {
                return true
            }
        }
        
        return false
    }
}
```

## Tests

```swift
class Problem_280Tests: XCTestCase {

    func test_graph_cycle() {
        
        let a = Node(value: 0)
        let b = Node(value: 1)
        let c = Node(value: 2)
        
        a.nodes = [b]
        b.nodes = [c]
        c.nodes = [a]
        
        XCTAssertTrue(a.containsCycle(current: []))
        
        let a2 = Node(value: 0)
        let b2 = Node(value: 1)
        let c2 = Node(value: 2)
        
        a2.nodes = [b2]
        b2.nodes = [c2]
        
        XCTAssertFalse(a2.containsCycle(current: []))
    }

}
```