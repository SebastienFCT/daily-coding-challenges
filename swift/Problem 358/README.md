## Description

This problem was asked by Dropbox.

Create a data structure that performs all the following operations in `O(1)` time:

- `plus`: Add a key with value 1. If the key already exists, increment its value by one.
- `minus`: Decrement the value of a key. If the key's value is currently 1, remove it.
- `get_max`: Return a key with the highest value.
- `get_min`: Return a key with the lowest value.

## Solution

```swift
struct SpaceOne<T: Hashable> {
    
    var keys: [T: Int]
    var values: [Int]
    
    mutating func plus(key: T) {
        if keys.keys.contains(key) {
            values[keys[key]!] += 1
        } else {
            keys[key] = values.count
            values.append(1)
        }
    }
    
    mutating func minus(key: T) {
        if !keys.keys.contains(key) {
            return
        }
        
        if values[keys[key]!] > 1 {
            values[keys[key]!] -= 1
            return
        } else {
            
            let index = keys[key]!
            
            keys.removeValue(forKey: key)
            
            // > O(1), not sure how to skip this. The alternative is setting the lost key as `nil` but it's bad for memory as the array will grow much faster
            for (key, value) in keys {
                if value == values.count-1 {
                    keys[key] = index
                    let val = values.removeLast()
                    values[index] = val
                    return
                }
            }
            
        }
    }
    
    // Not O(1)
    mutating func get_max() -> T? {
        
        var index = 0
        var max = 0
        
        for i in 0..<values.count {
            if values[i] > max {
                max = values[i]
                index = i
            }
        }
        
        for (key, value) in keys {
            if value == index {
                return key
            }
        }
        
        return nil
    }
    
    // Not O(1)
    mutating func get_min() -> T? {
        var index = 0
        var min = Int.max
        
        for i in 0..<values.count {
            if values[i] < min {
                min = values[i]
                index = i
            }
        }
        
        for (key, value) in keys {
            if value == index {
                return key
            }
        }
        
        return nil
    }
}
```