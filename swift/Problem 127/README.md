## Description

This problem was asked by Microsoft.

Let's represent an integer in a linked list format by having each node represent a digit in the number. The nodes make up the number in reversed order.

For example, the following linked list:

```
1 -> 2 -> 3 -> 4 -> 5
```

is the number 54321.

Given two linked lists in this format, return their sum in the same linked list format.

For example, given

```
9 -> 9
```

```
5 -> 2
```

return 124 (99 + 25) as:

```
4 -> 2 -> 1
```

## Solution

```swift
class Node {
    var value: Int
    var child: Node?
    
    init(value: Int, child: Node?) {
        self.value = value
        self.child = child
    }
    
    func values() -> [Int] {
        var result: [Int] = []
        
        result.append(value)
        
        if let child = child {
            result.append(contentsOf: child.values())
        }
        
        return result
    }
    
    static func + (left: Node, right: Node) -> Node {
        
        var leftValues = left.values()
        var rightValues = right.values()
        
        if leftValues.count > rightValues.count {
            rightValues = rightValues.fillToLength(length: leftValues.count)
        } else if rightValues.count > leftValues.count {
            leftValues = leftValues.fillToLength(length: rightValues.count)
        }
        
        var resultValues: [Int] = []
        var remaining = 0
        
        for i in 0..<leftValues.count {
            let sum = leftValues[i] + rightValues[i] + remaining
            let value = sum%10
            remaining = (sum-value) / 10
            
            resultValues.append(value)
        }
        
        while remaining != 0 {
            let value = remaining%10
            remaining -= value
            
            resultValues.append(value)
        }
        
        return Node.toNode(values: resultValues)
    }
    
    static func toNode(values: [Int]) -> Node {
        var copy = values
        
        let root = Node(value: copy.removeFirst(), child: nil)
        var currentNode = root
        
        while !copy.isEmpty {
            let node = Node(value: copy.removeFirst(), child: nil)
            currentNode.child = node
            currentNode = node
        }
        
        return root
    }
}

extension Array where Element == Int {
    func fillToLength(length: Int) -> [Int] {
        guard count < length else {
            fatalError("array out of bounds")
        }
        
        var copy = self
        copy.append(contentsOf: Array(repeating: 0, count: length-count))
        
        return copy
    }
}
```

## Test

```swift
class Problem_127Tests: XCTestCase {

    func test_example() {
        let left = Node(value: 9, child: Node(value: 9, child: nil))
        let right = Node(value: 5, child: Node(value: 2, child: nil))
        
        let sum = left + right
        XCTAssert(sum.values() == [4, 2, 1])
    }

}
```