## Description

This problem was asked by Apple.

Given a linked list, uniformly shuffle the nodes. What if we want to prioritize space over time?

## Solution

```swift
class Node {
    var value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
    
    func toString() -> String {
        
        var result = "\(self.value)"
        
        if let next = next {
            result += "->\(next.toString())"
        }
        
        return result
    }
}

struct LinkedList {
    var root: Node
    
    // Found uniform definition here: https://cs.stackexchange.com/a/47342
    
    mutating func uniformShuffle() {
        
        var nodes = allNodes()
        
        for i in 0..<nodes.count {
            let rand = Int.random(in: i...nodes.count-1)
            let tmp = nodes[rand]
            nodes[rand] = nodes[i]
            nodes[i] = tmp
        }
        
        let newRoot = nodes[0]
        var current: Node? = newRoot
        
        for i in 1..<nodes.count {
            current!.next = nodes[i]
            current = current?.next
        }
        
        current?.next = nil
        
        root = newRoot
    }
    
    func allNodes() -> [Node] {
        
        var result: [Node] = []
        
        var current: Node? = root
        
        while current != nil {
            result.append(current!)
            current = current?.next
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_337Tests: XCTestCase {

    func test_linkedlist_uniform_shuffle() {
        
        var ll = LinkedList(root: Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: Node(value: 5, next: nil))))))
        
        print(ll.root.toString())
        ll.uniformShuffle()
        print(ll.root.toString())
    }

}
```