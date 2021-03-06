## Description

This problem was asked by Bloomberg.

Determine whether there exists a one-to-one character mapping from one string `s1` to another `s2`.

For example, given `s1 = abc` and `s2 = bcd`, return true since we can map `a` to `b`, `b` to `c`, and `c` to `d`.

Given `s1 = foo` and `s2 = bar`, return false since the o cannot map to two characters.

## Solution

```swift
extension String {
    
    func hasOneToOneCharacterMapping(with: String) -> Bool {
        
        var copy = self
        var map: [Character : Character] = [:]
        
        for i in 0..<count {
            let character = copy[copy.index(copy.startIndex, offsetBy: i)]
            
            if let value = map[character] {
                copy = copy.replaceAtIndex(i, value)
            } else {
                let value = with[with.index(with.startIndex, offsetBy: i)]
                map[character] = value
                copy = copy.replaceAtIndex(i, value)
            }
        }
        
        return copy == with
    }
    
    func replaceAtIndex(_ index: Int, _ with: Character) -> String {
        var chars = Array(self)
        chars[index] = with
        let modifiedString = String(chars)
        
        return modifiedString
    }
}
```

## Test

```swift
class Problem_176Tests: XCTestCase {

    func test_example() {
        XCTAssertTrue("abc".hasOneToOneCharacterMapping(with: "bcd"))
        XCTAssertFalse("foo".hasOneToOneCharacterMapping(with: "bar"))
    }

}
```