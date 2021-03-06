## Description

This problem was asked by Amazon.

Huffman coding is a method of encoding characters based on their frequency. Each letter is assigned a variable-length binary string, such as 0101 or 111110, where shorter lengths correspond to more common letters. To accomplish this, a binary tree is built such that the path from the root to any leaf uniquely maps to a character. When traversing the path, descending to a left child corresponds to a `0` in the prefix, while descending right corresponds to `1`.

Here is an example tree (note that only the leaf nodes have letters):

```
        *
      /   \
    *       *
   / \     / \
  *   a   t   *
 /             \
c               s
```

With this encoding, cats would be represented as `0000110111`.

Given a dictionary of character frequencies, build a Huffman tree, and use it to determine a mapping between characters and their encoded binary strings.

## Solution

```swift
struct HuffmanTree {
    
    var characterFrequency: [Character : Int]
    
    func buildTree() -> Node? {
        
        let mapped = characterFrequency.map{ ($0.key, $0.value) }
        let sorted = mapped.sorted{ $0.1 > $1.1 }
        var sortedNodes = sorted.map{ Node(value: $0.0, frequency: $0.1) }
        
        while sortedNodes.count > 1 {
            let left = sortedNodes.remove(at: 0)
            let right = sortedNodes.remove(at: 0)
            
            let node = Node(value: "_", frequency: left.frequency + right.frequency)
            node.left = left
            node.right = right
            
            sortedNodes.append(node)
        }
        
        return sortedNodes.first
    }
}

class Node {
    var value: Character
    var frequency: Int
    var left: Node?
    var right: Node?
    
    init(value: Character, frequency: Int) {
        self.value = value
        self.frequency = frequency
        self.left = nil
        self.right = nil
    }
    
    init(value: Character, frequency: Int, left: Node?, right: Node?) {
        self.value = value
        self.frequency = frequency
        self.left = left
        self.right = right
    }
    
    func toHuffmanEncoding(current: String) -> [Character : String] {
        
        var result: [Character : String] = [:]
        
        if value != "_" {
            result[value] = current
        } else {
            if let left = left {
                result = result.merging(left.toHuffmanEncoding(current: "\(current)0")){ (current, _) in current }
            }
            if let right = right {
                result = result.merging(right.toHuffmanEncoding(current: "\(current)1")){ (current, _) in current }
            }
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_261Tests: XCTestCase {

    func test_example() {
        
        // taken from https://en.wikipedia.org/wiki/Letter_frequency
        
        let charFrequency: [Character : Int] = [
            "c": 2,
            "a": 8,
            "t": 9,
            "s": 6,
            "o": 7
        ]
        
        let input = HuffmanTree(characterFrequency: charFrequency)
        print(input.buildTree()?.toHuffmanEncoding(current: ""))
    }

}
```