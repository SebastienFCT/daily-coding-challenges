## Description

This problem was asked by Indeed.

Given a 32-bit positive integer N, determine whether it is a power of four in faster than O(log N) time.

## Solution

```swift
extension Int {
    
    // O(log N)
    func isPowerOfFour() -> Bool {
        
        var copy = self
        while copy != 1 {
            if copy % 4 != 0 {
                return false
            }
            
            copy /= 4
        }
        
        return true
    }
}
```