## Description

This problem was asked by Uber.

Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand. Find the minimum element in O(log N) time. You may assume the array does not contain duplicates.

For example, given [5, 7, 10, 3, 4], return 3.

## Solution

```swift
extension Array where Element == Int {
    
    func minValue() -> Int {
        
        // 9, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8
        
        var index = count / 2
        
        while true {
            if index == 0 || index == count-1 {
                return self[index]
            }
            
            if self[index+1] < self[index] {
                return self[index+1]
            }
            
            if self[index-1] > self[index] {
                return self[index-1]
            }
            
            let newIndex = index + (index / 2)
            
            if self[newIndex] < self[index] {
                index = newIndex
            } else {
                index = index / 2
            }
        }
    }
}
```

## Test

```swift
class Problem_203Tests: XCTestCase {

    func test_example() {
        XCTAssert([5, 7, 10, 3, 4].minValue() == 3)
    }
    
    func test_case_2() {
        XCTAssert([9, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8].minValue() == 1)
    }
    
    func test_case_3() {
        XCTAssert([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].minValue() == 1)
    }

}
```