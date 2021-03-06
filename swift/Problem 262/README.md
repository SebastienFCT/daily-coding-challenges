## Description

This problem was asked by Mozilla.

A bridge in a connected (undirected) graph is an edge that, if removed, causes the graph to become disconnected. Find all the bridges in a graph.

## Solution

```swift
class Node: Equatable {
    
    // To make it simpler, we assume node values are unique
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }
    
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

class Edge {
    var left: Node
    var right: Node
    
    init(left: Node, right: Node) {
        self.left = left
        self.right = right
    }
    
    func toString() -> String {
        return "\(left.value)--\(right.value)"
    }
}

struct Graph {
    var nodes: [Node]
    var edges: [Edge]
    
    func findBridges() -> [Edge] {
        
        var result: [Edge] = []
        
        for i in 0..<edges.count {
            
            var copy = edges
            let currentEdge = copy.remove(at: i)
            
            if !copy.isEmpty {
                let node = copy.first!.left
                let reachable = reachableNodes(fromEdges: copy, withNode: node)
                
                if reachable.count < nodes.count {
                    result.append(currentEdge)
                }
            }
        }
        
        return result
    }
    
    func reachableNodes(fromEdges: [Edge], withNode: Node) -> [Node] {
        
        var result: [Node] = []
        
        if fromEdges.isEmpty {
            return result
        }
        
        for i in 0..<fromEdges.count {
            
            var copy = fromEdges
            let currentEdge = copy.remove(at: i)
            
            if currentEdge.left == withNode {
                if !result.contains(currentEdge.right) {
                    result.append(currentEdge.right)
                }
                
                result.append(contentsOf: reachableNodes(fromEdges: copy, withNode: currentEdge.right))
            }
            
            if currentEdge.right == withNode {
                if !result.contains(currentEdge.left) {
                    result.append(currentEdge.left)
                }
                
                result.append(contentsOf: reachableNodes(fromEdges: copy, withNode: currentEdge.left))
            }
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_262Tests: XCTestCase {

    func test_graph_bridges() {
        
        let a = Node(value: 1)
        let b = Node(value: 2)
        let c = Node(value: 3)
        let d = Node(value: 4)
        let e = Node(value: 5)
        
        let input = Graph(
            nodes: [a, b, c, d, e],
            edges: [
                Edge(left: a, right: b),
                Edge(left: b, right: c),
                Edge(left: c, right: d),
                Edge(left: d, right: e),
                Edge(left: e, right: a)
            ]
        )
        
        let actual = input.findBridges()
        
        XCTAssert(actual.count == 5)
        
        for edge in actual {
            print(edge.toString())
        }
    }
    
    func test_graph_bridges_2() {
        
        let a = Node(value: 1)
        let b = Node(value: 2)
        let c = Node(value: 3)
        
        let input = Graph(
            nodes: [a, b, c],
            edges: [
                Edge(left: a, right: b),
                Edge(left: a, right: c),
                Edge(left: b, right: a),
                Edge(left: b, right: c),
                Edge(left: c, right: a),
                Edge(left: c, right: b)
            ]
        )
        
        let actual = input.findBridges()
        
        XCTAssert(actual.count == 0)
        
    }

}
```