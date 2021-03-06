## Description

This problem was asked by Quora.

You are given a list of `(website, user)` pairs that represent users visiting websites. Come up with a program that identifies the top `k` pairs of websites with the greatest similarity.

For example, suppose `k = 1`, and the list of tuples is:

```
[('a', 1), ('a', 3), ('a', 5),
 ('b', 2), ('b', 6),
 ('c', 1), ('c', 2), ('c', 3), ('c', 4), ('c', 5)
 ('d', 4), ('d', 5), ('d', 6), ('d', 7),
 ('e', 1), ('e', 3), ('e': 5), ('e', 6)]
 ```

Then a reasonable similarity metric would most likely conclude that a and e are the most similar, so your program should return `[('a', 'e')]`.

## Solution

```swift
typealias Website = Character
typealias Visit = (website: Website, user: Int)
typealias WebsitePairWithSimilarities = (left: Website, right: Website, count: Int)

struct Web {
    
    var visits: [Visit]
    
    func topSimilarities(forPairCount k: Int) -> [WebsitePairWithSimilarities] {
        
        var result: [WebsitePairWithSimilarities] = []
        
        let allVisits = allVisitsPerWebsite()
        let allKeys = allVisits.map{ $0.key }
        
        for i in 0..<allKeys.count-1 {
            for j in i+1..<allKeys.count {
                if let left = allVisits[allKeys[i]], let right = allVisits[allKeys[j]] {
                    
                    let similarityCount = left.intersection(right).count
                    let differenceCount = left.symmetricDifference(right).count
                    
                    let count = similarityCount-differenceCount
                    
                    result.append((allKeys[i], allKeys[j], count))
                }
            }
        }
        
        let sorted = result.sorted{ $0.count > $1.count }
        
        guard sorted.count > k else {
            return sorted
        }
        
        return Array(sorted.prefix(k))
    }
    
    func allVisitsPerWebsite() -> [Website : Set<Int>] {
        
        var result: [Website : Set<Int>] = [:]
        
        for visit in visits {
            
            if !result.keys.contains(visit.website) {
                result[visit.website] = Set()
            }
            
            result[visit.website]!.insert(visit.user)
        }
        
        return result
    }
    
    
}
```

## Tests

```swift
class Problem_287Tests: XCTestCase {

    func test_example() {
        
        let input = Web(visits: [
            ("a", 1), ("a", 3), ("a", 5),
            ("b", 2), ("b", 6),
            ("c", 1), ("c", 2), ("c", 3), ("c", 4), ("c", 5),
            ("d", 4), ("d", 5), ("d", 6), ("d", 7),
            ("e", 1), ("e", 3), ("e", 5), ("e", 6)
        ])
        
        let actual = input.topSimilarities(forPairCount: 1)
        
        XCTAssert(actual.contains(where: { (val) -> Bool in
            (val.left == "e" && val.right == "a") || (val.left == "a" && val.right == "e")
        }))
    }

}
```