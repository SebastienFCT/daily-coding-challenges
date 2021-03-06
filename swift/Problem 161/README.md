## Description

This problem was asked by Facebook.

Given a 32-bit integer, return the number with its bits reversed.

For example, given the binary number `1111 0000 1111 0000 1111 0000 1111 0000`, return `0000 1111 0000 1111 0000 1111 0000 1111`.

## Solution

```swift
extension UInt32 {
    // Solution from wty21cn at https://github.com/wty21cn/leetcode-swift/blob/master/leetcode-swift/Easy/q190-reverse-bits.swift
    func reverseBits() -> UInt32 {
        var copy = self
        
        var result: UInt32 = 0
        var i: UInt32 = 32
        
        while i > 0 && copy != 0 {
            result = result << 1 + copy & 0b1
            copy = copy >> 1
            i -= 1
        }
        
        result = result << i
        
        return result
    }
}
```

## Test

```swift
class Problem_161Tests: XCTestCase {

    func test_bit_reserver() {
        print(UInt32(8).reverseBits() == UInt32(268435456))
    }

}
```