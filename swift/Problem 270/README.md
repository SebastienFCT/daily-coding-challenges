## Description

This problem was asked by Twitter.

A network consists of nodes labeled `0` to `N`. You are given a list of edges `(a, b, t)`, describing the time `t` it takes for a message to be sent from node a to node b. Whenever a node receives a message, it immediately passes the message on to a neighboring node, if possible.

Assuming all nodes are connected, determine how long it will take for every node to receive a message that begins at node 0.

For example, given `N = 5`, and the following edges:

```
edges = [
    (0, 1, 5),
    (0, 2, 3),
    (0, 5, 4),
    (1, 3, 8),
    (2, 3, 1),
    (3, 5, 10),
    (3, 4, 5)
]
```

You should return `9`, because propagating the message from `0 -> 2 -> 3 -> 4` will take that much time.


## Solution

```swift
typealias Edge = (from: Int, to: Int, time: Int)

struct Network {
    
    var length: Int
    
    func shortestPropagationTime(forEdges edges: [Edge]) -> Int? {
        
        var current: [Bool] = [true]
        
        for _ in 1..<length {
            current.append(false)
        }
        
        let candidates = propagationtimes(current: current, last: 0, count: 0, edges: edges)
        let sorted = candidates.sorted{ $0 < $1 }
        
        return sorted.first
    }
    
    private func propagationtimes(current: [Bool], last: Int, count: Int, edges: [Edge]) -> [Int] {
        
        var result: [Int] = []
        
        for i in 0..<edges.count {
            let edge = edges[i]
            
            if edge.from == last {
                if edge.to == length-1 {
                    result.append(count + edge.time)
                } else {
                    var copyCurrent = current
                    
                    if edge.to >= 0 && edge.to < length {
                        copyCurrent[edge.to] = true
                    }
                    var copyLast = last
                    copyLast = edge.to
                    var copyCount = count
                    copyCount += edge.time
                    var copyEdges = edges
                    copyEdges.remove(at: i)
                    
                    result.append(contentsOf: propagationtimes(current: copyCurrent, last: copyLast, count: copyCount, edges: copyEdges))
                }
            }
        }
        
        return result
        
    }
}
```

## Tests

```swift
class Problem_270Tests: XCTestCase {

    func test_example() {
        
        let edges: [Edge] = [
            (0, 1, 5),
            (0, 2, 3),
            (0, 5, 4),
            (1, 3, 8),
            (2, 3, 1),
            (3, 5, 10),
            (3, 4, 5)
        ]
        
        let network = Network(length: 5)
        
        let actual = network.shortestPropagationTime(forEdges: edges)
        let expected = 9
        
        XCTAssert(actual == expected)
    }

}
```