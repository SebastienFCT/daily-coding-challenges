## Description

This problem was asked by LinkedIn.

Given a set of characters `C` and an integer `k`, a De Bruijn sequence is a cyclic sequence in which every possible `k`-length string of characters in `C` occurs exactly once.

For example, suppose `C = {0, 1}` and `k = 3`. Then our sequence should contain the substrings `{'000', '001', '010', '011', '100', '101', '110', '111'}`, and one possible solution would be `00010111`.

Create an algorithm that finds a De Bruijn sequence.

## Solution

```swift
// Algorith taken from https://www.geeksforgeeks.org/de-bruijn-sequence-set-1/
// I didn't get the explanation.

struct DeBrujinSequence {
    
    var seen: Set<String>
    var edges: [Int]
    
    mutating func build(n: Int, characters: Set<Character>) -> String {
        let k = characters.count
        let string = characters.reduce(""){ "\($0)\($1)" }
        
        seen = Set<String>()
        edges = []
        
        let startingNode = buildString(length: n-1, withChar: string.first!)
        dfs(node: startingNode, k: k, string: string)
        
        var result = ""
        
        let edgesCount = Int(exactly: pow(Double(k), Double(n)))!
        
        for i in 0..<edgesCount {
            result += String(string[edges[i]])
        }
        
        result += startingNode
        
        return result
    }
    
    mutating private func dfs(node: String, k: Int, string: String) {
        for i in 0..<k {
            let value = "\(node)\(string[i])"
            if !seen.contains(value) {
                seen.insert(value)
                dfs(node: String(value.suffix(value.count-1)), k: k, string: string)
                edges.append(i)
            }
        }
    }
    
    private func buildString(length: Int, withChar: Character) -> String {
        
        var result = ""
        
        for _ in 0..<length {
            result += "\(withChar)"
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_264Tests: XCTestCase {

    func test_implementation() {
        
        var dbs = DeBrujinSequence(seen: Set(), edges: [])
        var characters = Set<Character>()
        characters.insert("0")
        characters.insert("1")
        
        let output = dbs.build(n: 3, characters: characters)
        
        print(dbs.edges)
        print(output)
    }

}
```