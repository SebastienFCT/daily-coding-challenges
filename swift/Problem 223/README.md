## Description

This problem was asked by Palantir.

Typically, an implementation of in-order traversal of a binary tree has `O(h)` space complexity, where `h` is the height of the tree. Write a program to compute the in-order traversal of a binary tree using `O(1)` space.


## Solution

```swift
// Solution from https://www.geeksforgeeks.org/inorder-tree-traversal-without-recursion-and-without-stack/

class Node {
    var value: Int
    var left: Node?
    var right: Node?
    var parent: Node?
    
    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    func MorrisTraversal() {
        
        var current: Node? = self
        var previous: Node? = nil
        
        while current != nil {
            
            if current?.left == nil {
                print(current?.value)
                current = current?.right
            } else {
                previous = current?.left
                
                while (previous?.right != nil && previous?.right?.value != current?.value) {
                    previous = previous?.right
                }
                
                if previous?.right == nil {
                    previous?.right = current
                    current = current?.left
                } else {
                    previous?.right = nil
                    print(current?.value)
                    current = current?.right
                }
            }
        }
    }
}
```