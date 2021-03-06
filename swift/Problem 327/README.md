## Description

This problem was asked by Salesforce.

Write a program to merge two binary trees. Each node in the new tree should hold a value equal to the sum of the values of the corresponding nodes of the input trees.

If only one input tree has a node in a given position, the corresponding node in the new tree should match that input node.

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
    
    func merge(withTree tree: Node?) -> Node? {
        
        guard let tree = tree else {
            return self
        }
        
        let selfInLevels = toLevels(current: [[self]])
        let treeInLevels = toLevels(current: [[tree]])
        
        let maxCount = max(selfInLevels.count-1, treeInLevels.count-1)
        
        var newInLevels: [[Node?]] = []
        
        for i in 0...maxCount {
            
            var newRow: [Node?] = []
            
            for j in 0...(max(selfInLevels[i].count-1, treeInLevels[i].count-1)) {
                
                if j < selfInLevels[i].count && j < treeInLevels[i].count {
                    
                    if let sNode = selfInLevels[i][j], let tNode = treeInLevels[i][j] {
                        newRow.append(Node(value: sNode.value + tNode.value))
                        continue
                    }
                    
                    if let sNode = selfInLevels[i][j] {
                        newRow.append(Node(value: sNode.value))
                        continue
                    }
                    
                    if let tNode = treeInLevels[i][j] {
                        newRow.append(Node(value: tNode.value))
                        continue
                    }
                    
                    newRow.append(nil)
                    continue
                }
            }
            
            newInLevels.append(newRow)
        }
        
        for i in 0...newInLevels.count-2 {
            
            for j in 0...newInLevels[i].count-1 {
                
                if newInLevels[i][j] != nil {
                    newInLevels[i][j]?.left = newInLevels[i+1][j*2]
                    newInLevels[i][j]?.right = newInLevels[i+1][j*2+1]
                }
            }
        }
        
        return newInLevels[0][0]
    }
    
    private func toLevels(current: [[Node?]]) -> [[Node?]] {

        var copy = current
        var newRow: [Node?] = []
        
        let lastIndex = copy.count-1
        
        for node in copy[lastIndex] {
            
            if let node = node {
                newRow.append(node.left)
                newRow.append(node.right)
            } else {
                newRow.append(contentsOf: [nil, nil])
            }
        }
        
        if newRow.filter({ $0 != nil }).isEmpty {
            return current
        }
        
        copy.append(newRow)
        
        return toLevels(current: copy)
    }
}
```

## Tests

```swift
class Problem_327Tests: XCTestCase {

    func test_merge_trees() {
        
        let left = Node(value: 1
            , left: Node(value: 2
                , left: Node(value: 3)
                , right: nil)
            , right: Node(value: 5
                , left: Node(value: 2)
                , right: Node(value: 1))
        )
        
        let right = Node(value: 1
            , left: Node(value: 2
                , left: Node(value: 3)
                , right: nil)
            , right: Node(value: 5
                , left: Node(value: 2)
                , right: Node(value: 1))
        )
        
        let actual = left.merge(withTree: right)
        
        XCTAssert(actual?.value == 2)
        XCTAssert(actual?.left?.value == 4)
        XCTAssert(actual?.left?.left?.value == 6)
        XCTAssert(actual?.left?.right?.value == nil)
    }

}
```