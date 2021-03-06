## Description

This problem was asked by PayPal.

Given a string and a number of lines `k`, print the string in zigzag form. In zigzag, characters are printed out diagonally from top left to bottom right until reaching the `kth` line, then back up to top right, and so on.

For example, given the sentence `"thisisazigzag"` and `k = 4`, you should print:

```
t     a     g
 h   s z   a
  i i   i z
   s     g
```

## Solution

```swift
struct Zigzag {
    
    func printZigzag(value: String, lines k: Int) {
        let lines = build2(value: value, lines: k)
        
        let mapped = lines.map{ $0.reduce("") { "\($0)\($1)" } }
        for line in mapped {
            print(line)
        }
    }
    
    func build2(value: String, lines k: Int) -> [[Character]] {
        
        var lines: [[Character]] = []
        for _ in 1...k {
            lines.append([])
        }
        
        var currentLine = 0
        var ascending = true
        
        for character in value {
            
            for i in 0..<lines.count {
                if i == currentLine {
                    lines[i].append(character)
                } else {
                    lines[i].append(" ")
                }
            }
            
            if ascending {
                currentLine += 1
                if currentLine == k-1 { ascending.toggle() }
            } else {
                currentLine -= 1
                if currentLine == 0 { ascending.toggle() }
            }
        }
        
        return lines
    }
}
```

## Tests

```swift
class Problem_253Tests: XCTestCase {

    func test_example() {
     
        
        let zigzag = Zigzag()
        zigzag.printZigzag(value: "thisisazigzag", lines: 4)
    }

}
```