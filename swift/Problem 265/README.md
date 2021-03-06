## Description

This problem was asked by Atlassian.

MegaCorp wants to give bonuses to its employees based on how many lines of codes they have written. They would like to give the smallest positive amount to each worker consistent with the constraint that if a developer has written more lines of code than their neighbor, they should receive more money.

Given an array representing a line of seats of employees at MegaCorp, determine how much each one should get paid.

For example, given `[10, 40, 200, 1000, 60, 30]`, you should return `[1, 2, 3, 4, 2, 1]`.


## Solution

```swift
extension Array where Element == Int {
    
    func distributeBonuses() -> [Int] {
        
        var result: [Int] = []
        
        let groups = buildGroups()
        
        for group in groups {
            
            if group.1 == .descending {
                for i in stride(from: group.0, through: 1, by: -1) {
                    result.append(result.last ?? 0 <= i ? i - 1 : i)
                }
            } else {
                for i in 1...group.0 {
                    result.append(result.last ?? 0 >= i ? i + 1 : i)
                }
            }
        }
        
        return result
    }
    
    enum OrderType {
        case ascending
        case descending
    }
    
    typealias Group = (Int, OrderType)
    
    func buildGroups() -> [Group] {
        
        guard count > 0 else {
            return []
        }
        
        guard count > 1 else {
            return [(first!, .descending)]
        }
        
        var ordering: OrderType? = nil
        var current = first!
        var total = 1
        
        ordering = self[1] > current ? .ascending : .descending
        current = self[1]
        total += 1
        
        guard count > 2 else {
            return [(total, ordering!)]
        }
        
        var result: [Group] = []
        
        for i in 2..<count {
            if ((ordering == .ascending && self[i] > current) || (ordering == .descending && self[i] < current)) {
                current = self[i]
                total += 1
            } else {
                result.append((total, ordering!))
                let rest = Array(suffix(count-i))
                result.append(contentsOf: rest.buildGroups())
                break
            }
        }
        
        return result
    }
}
```

## Tests

```swift
class Problem_265Tests: XCTestCase {

    func test_example() {
        let input = [10, 40, 200, 1000, 60, 30]
        let actual = input.distributeBonuses()
        let expected = [1, 2, 3, 4, 2, 1]
        
        XCTAssert(actual == expected)
    }
    
    func test_example_other() {
        let input = [10, 40, 200, 1000, 60, 30, 20, 50, 70, 50, 10]
        let actual = input.distributeBonuses()
        print(actual)
    }

}
```