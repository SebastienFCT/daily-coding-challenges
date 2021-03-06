## Description

This problem was asked by Amazon.

Given a complete binary tree, count the number of nodes in faster than O(n) time. Recall that a complete binary tree has every level filled except the last, and the nodes in the last level are filled starting from the left.

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
    
//    func countNodes() -> Int {
//        return 1 + (left?.countNodes() ?? 0) + (right?.countNodes() ?? 0)
//    }
    
    func countNodes() -> Int {
        return binaryNodeCount(currentLeft: 0, currentRight: 0)
    }
    
    func binaryNodeCount(currentLeft: Int, currentRight: Int) -> Int {
        
        var leftCount = currentLeft
        var copy: Node? = self
        
        while copy != nil {
            copy = copy?.left
            leftCount += 1
        }
        
        var rightCount = currentRight
        copy = self
        
        while copy != nil {
            copy = copy?.right
            rightCount += 1
        }
        
        if leftCount == rightCount {
            return Int(exactly: pow(Double(2), Double(leftCount-1)))!
        }
        
        return 1 + (left?.binaryNodeCount(currentLeft: leftCount-1, currentRight: 0) ?? 0) + (right?.binaryNodeCount(currentLeft: 0, currentRight: rightCount-1) ?? 0)
    }
}
```

## Test

```swift
class Problem_204Tests: XCTestCase {

    func test_example() {
        
        let root = Node(value: 5
            , left: Node(value: 3
                , left: Node(value: 2)
                , right: Node(value: 4)
            )
            , right: Node(value: 7
                , left: Node(value: 6)
                , right: nil
            )
        )
        
        XCTAssert(root.countNodes() == 6)
    }

}
```