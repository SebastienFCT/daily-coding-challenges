## Description

This problem was asked by Google.

Implement an LRU (Least Recently Used) cache. It should be able to be initialized with a cache size `n`, and contain the following methods:

* `set(key, value)`: sets `key` to `value`. If there are already n items in the cache and we are adding a new item, then it should also remove the least recently used item.
* `get(key)`: gets the value at `key`. If no such key exists, return null.

Each operation should run in `O(1)` time.

## Solution

A good way to find an element quickly is to use a dictionary
 
To keep track of the elements that are the least used, we can create a FIFO linked list, the last element of the list is always the first element to be removed if we reach the limit size of the list

The dictionary gives us a reference to all our node so that we can remove them quickly

```swift
class Node {
    var key: String
    var value: String
    var previous: Node?
    var next: Node?
    
    init(key: String, value: String, previous: Node?, next: Node?) {
        self.key = key
        self.value = value
        self.previous = previous
        self.next = next
    }
}

struct LRU {
    var maxSize: Int
    var cache: [String : Node]
    var root: Node?
    
    mutating func set(key: String, node: Node) {
        if cache.keys.contains(node.value) {
            // The key exists, we just need to clear the linked list
            remove(node: node)
            add(node: node)
            return
        }
        
        if cache.count >= maxSize {
            removeLast()
            add(node: node)
            return
        }
        
        add(node: node)
        return
    }
    
    mutating func removeLast() {
        guard let root = root, let previous = root.previous else {
            return
        }
        
        remove(node: previous)
    }
    
    mutating func add(node: Node) {
        if let root = root {
            if let last = root.previous {
                last.next = node
                root.previous = node
                
                node.previous = last
                node.next = root
            }
        }
        
        if cache.keys.contains(node.key) {
            return
        }
        
        cache[node.key] = node
    }
    
    mutating func remove(node: Node) {
        if cache.keys.contains(node.key) {
            cache.removeValue(forKey: node.key)
        }
        
        let previous = node.previous
        let next = node.next
        
        previous?.next = next
        next?.previous = previous
    }
    
    mutating func get(key: String) -> Node? {
        
        if cache.keys.contains(key) {
            // we also need to refresh the linked list as getting the key refreshes the element
            guard let node = cache[key] else {
                fatalError("couldn't find node in cache")
            }
            
            remove(node: node)
            add(node: node)
            return node
        }
        
        return nil
    }
}
```

## Test

```swift
class Problem_52Tests: XCTestCase {

    func test_1() {
        var lru = LRU(maxSize: 2, cache: [:], root: nil)
        
        XCTAssertNil(lru.get(key: "key1"))
        
        lru.add(node: Node(key: "key1", value: "value1", previous: nil, next: nil))
        XCTAssertNotNil(lru.get(key: "key1"))
        
        lru.add(node: Node(key: "key2", value: "value2", previous: nil, next: nil))
        XCTAssertNotNil(lru.get(key: "key1")) // key 2 is the least use
        
        lru.add(node: Node(key: "key3", value: "value3", previous: nil, next: nil)) // key 2 should be removed from the cache
        XCTAssertNotNil(lru.get(key: "key2"))
    }

}
```