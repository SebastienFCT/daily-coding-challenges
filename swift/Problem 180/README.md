## Description

This problem was asked by Google.

Given a stack of N elements, interleave the first half of the stack with the second half reversed using only one other queue. This should be done in-place.

Recall that you can only push or pop from a stack, and enqueue or dequeue from a queue.

For example, if the stack is [1, 2, 3, 4, 5], it should become [1, 5, 2, 4, 3]. If the stack is [1, 2, 3, 4], it should become [1, 4, 2, 3].

Hint: Try working backwards from the end state.

## Solution

```swift
struct Stack {
    var value: [Int]
    
    mutating func push(element: Int) {
        value.append(element)
    }
    
    mutating func pop() -> Int? {
        if value.isEmpty {
            return nil
        }
        
        return value.removeLast()
    }
}

struct Queue {
    var value: [Int]
    
    mutating func enqueue(element: Int) {
        value.insert(element, at: 0)
    }
    
    mutating func dequeue() -> Int? {
        if value.isEmpty {
            return nil
        }
        
        return value.removeLast()
    }
}

extension Stack {
    mutating func interleave(count: Int = 1) {
        var queue = Queue(value: [])
        
        for _ in 0...value.count-1-count {
            queue.enqueue(element: self.pop()!)
        }
        
        while !queue.value.isEmpty {
            self.push(element: queue.dequeue()!)
        }
        
        if count < value.count-1 {
            interleave(count: count+1)
        }
    }
}
```

## Test

```swift
class Problem_180Tests: XCTestCase {

    func test_example_1() {
        var stack = Stack(value: [1, 2, 3, 4, 5])
        stack.interleave()
        
        XCTAssert(stack.value == [1, 5, 2, 4, 3])
    }
    
    func test_example_2() {
        var stack = Stack(value: [1, 2, 3, 4])
        stack.interleave()
        
        XCTAssert(stack.value == [1, 4, 2, 3])
    }

}
```