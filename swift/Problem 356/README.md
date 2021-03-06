## Description

This problem was asked by Netflix.

Implement a queue using a set of fixed-length arrays.

The queue should support `enqueue`, `dequeue`, and `get_size` operations.

## Solution

```swift
class Queue<T> {
    
    var arrays: [[T?]]
    var arraySize: Int
    var arrayCount: Int
    var currentIndex: Int
    
    init(arraySize: Int, arrayCount: Int) {
        arrays = []
        
        for _ in 1...arrayCount {
            arrays.append(Array(repeating: nil, count: arraySize))
        }
        
        self.arraySize = arraySize
        self.arrayCount = arrayCount
        self.currentIndex = 0
    }
    
    func enqueue(item: T) {
        
        if currentIndex == arrayCount * arraySize - 1 {
            fatalError("Queue is full")
        }
        
        if currentIndex == 0 {
            arrays[0][0] = item
            currentIndex += 1
            return
        }
        
        var previous: T = item
        
        for i in 0...currentIndex+1 {
            let arrayIndex = i / arraySize
            let itemIndex = i % arraySize
            
            if arrays[arrayIndex][itemIndex] != nil {
                let tmp = arrays[arrayIndex][itemIndex]!
                arrays[arrayIndex][itemIndex] = previous
                previous = tmp
            } else {
                arrays[arrayIndex][itemIndex] = previous
            }
        }
        
        currentIndex += 1
    }
    
    func dequeue() {
        
        if currentIndex == 0 {
            return
        }
        
        let arrayIndex = currentIndex / arraySize
        let itemIndex = currentIndex % arraySize
        
        arrays[arrayIndex][itemIndex] = nil
        currentIndex -= 1
    }
    
    func getSize() -> Int {
        
        return currentIndex
    }
    
    func printable() -> String {
        
        var result = ""
        
        for i in 0...currentIndex-1 {
            let arrayIndex = i / arraySize
            let itemIndex = i % arraySize
            
            result = result.isEmpty ? "\(arrays[arrayIndex][itemIndex]!)" : "\(result)->\(arrays[arrayIndex][itemIndex]!)"
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_356Tests: XCTestCase {

    func test_queue() {
        
        let queue = Queue<Int>(arraySize: 3, arrayCount: 5)
        
        XCTAssert(queue.getSize() == 0)
        
        queue.dequeue()
        
        XCTAssert(queue.getSize() == 0)
        
        queue.enqueue(item: 1)
        queue.enqueue(item: 2)
        queue.enqueue(item: 3)
        queue.enqueue(item: 4)
        queue.enqueue(item: 5)
        
        XCTAssert(queue.printable() == "5->4->3->2->1")
        XCTAssert(queue.getSize() == 5)
        
        queue.dequeue()
        
        XCTAssert(queue.printable() == "5->4->3->2")
        XCTAssert(queue.getSize() == 4)
        
    }

}
```