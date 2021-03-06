## Description

This problem was asked by Uber.

Implement a 2D iterator class. It will be initialized with an array of arrays, and should implement the following methods:

- `next()`: returns the next element in the array of arrays. If there are no more elements, raise an exception.
- `has_next()`: returns whether or not the iterator still has elements left.

For example, given the input [[1, 2], [3], [], [4, 5, 6]], calling next() repeatedly should output `1, 2, 3, 4, 5, 6`.

Do not use flatten or otherwise clone the arrays. Some of the arrays can be empty.

## Solution

```swift
class Iterator2D {
    var elements: [[Int]]
    var parentIndex: Int
    var index: Int
    
    init(elements: [[Int]]) {
        self.elements = elements
        self.parentIndex = 0
        self.index = -1
    }
    
    func next() -> Int? {
        
        if !has_next() {
            return nil
        }
        
        return nextElement()
    }
    
    private func nextElement() -> Int? {
        if index >= elements[parentIndex].count-1 {
            index = 0
            parentIndex += 1
        } else {
            index += 1
        }
        
        if elements[parentIndex].isEmpty {
            return nextElement()
        }
        
        return elements[parentIndex][index]
    }
    
    func has_next() -> Bool {
        return hasNextFrom(parentIndex: self.parentIndex, index: self.index)
    }
    
    private func hasNextFrom(parentIndex: Int, index: Int) -> Bool {
        if parentIndex > elements.count-1  {
            return false
        }
        
        if index >= elements[parentIndex].count-1 {
            return hasNextFrom(parentIndex: parentIndex+1, index: 0)
        }
        
        if elements[parentIndex].isEmpty {
            
            if parentIndex <= elements.count {
                return hasNextFrom(parentIndex: parentIndex+1, index: 0)
            } else {
                return false
            }
        }
        
        return true
    }
}
```

## Test

```swift
class Problem_166Tests: XCTestCase {

    func test_example() {
        let iterator = Iterator2D(elements: [[1, 2], [3], [], [4, 5, 6]])
        XCTAssertTrue(iterator.has_next())
        XCTAssert(iterator.next() == 1)
        XCTAssert(iterator.next() == 2)
        XCTAssertTrue(iterator.has_next())
        XCTAssert(iterator.next() == 3)
        XCTAssert(iterator.next() == 4)
        XCTAssert(iterator.next() == 5)
        XCTAssertTrue(iterator.has_next())
        XCTAssert(iterator.next() == 6)
        XCTAssertFalse(iterator.has_next())
        
    }

}
```