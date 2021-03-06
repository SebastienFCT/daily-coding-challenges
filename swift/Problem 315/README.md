## Description

This problem was asked by Google.

In linear algebra, a Toeplitz matrix is one in which the elements on any given diagonal from top left to bottom right are identical.

Here is an example:

```
1 2 3 4 8
5 1 2 3 4
4 5 1 2 3
7 4 5 1 2
```

Write a program to determine whether a given input is a Toeplitz matrix.

## Solution

```swift
typealias Position = (row: Int, column: Int)

extension Array where Element == Array<Int> {
    
    
    func isToeplitz() -> Bool {
        
        for i in stride(from: count-1, through: 0, by: -1) {
            
            var row = i
            var column = 0
            var nextVal: (value: Int, pos: Position)? = (self[row][column], (row, column))
            
            guard let value = nextVal?.value else {
                fatalError("logic failed")
            }
            
            while nextVal != nil {
                if nextVal?.value != value {
                    return false
                }
                
                row = nextVal!.pos.row
                column = nextVal!.pos.column
                nextVal = next(current: nextVal!.pos)
            }
        }
        
        for i in 1..<count {
            
            var row = 0
            var column = i
            
            var nextVal: (value: Int, pos: Position)? = (self[row][column], (row, column))
            
            guard let value = nextVal?.value else {
                fatalError("logic failed")
            }
            
            while nextVal != nil {
                if nextVal?.value != value {
                    return false
                }
                
                row = nextVal!.pos.row
                column = nextVal!.pos.column
                nextVal = next(current: nextVal!.pos)
            }
        }
        
        return true
    }
    
    private func next(current: Position) -> (value: Int, pos: Position)? {
        
        guard current.row < count-1 && current.column < count-1 else {
            return nil
        }
        
        return (self[current.row+1][current.column+1], (current.row+1, current.column+1))
    }
}
```

## Tests

```swift
class Problem_315Tests: XCTestCase {

    func test_example() {
        
        let input = [
            [1, 2, 3, 4, 8],
            [5, 1, 2, 3, 4],
            [4, 5, 1, 2, 3],
            [7, 4, 5, 1, 2]
        ]
        
        XCTAssertTrue(input.isToeplitz())
        
        
        let input2 = [
            [111, 2, 3, 4, 8],
            [5, 1, 2, 3, 4],
            [4, 5, 1, 2, 3],
            [7, 4, 5, 1, 2]
        ]
        
        XCTAssertFalse(input2.isToeplitz())
    }

}
```