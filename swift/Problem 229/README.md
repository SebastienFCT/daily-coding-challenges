## Description

This problem was asked by Flipkart.

Snakes and Ladders is a game played on a 10 x 10 board, the goal of which is get from square 1 to square 100. On each turn players will roll a six-sided die and move forward a number of spaces equal to the result. If they land on a square that represents a snake or ladder, they will be transported ahead or behind, respectively, to a new square.

Find the smallest number of turns it takes to play snakes and ladders.

For convenience, here are the squares representing snakes and ladders, and their outcomes:

```
snakes = {16: 6, 48: 26, 49: 11, 56: 53, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 98: 78}
ladders = {1: 38, 4: 14, 9: 31, 21: 42, 28: 84, 36: 44, 51: 67, 71: 91, 80: 100}
```


## Solution

```swift
struct SnakesAndLadders {
    var snakes: [Int: Int]
    var ladders: [Int: Int]
    
    func optimalPath() -> [Int] {
        
        let candidates = next(positions: [0])
        let sorted = candidates.sorted{ $0.count < $1.count }
        
        return sorted.first!
    }
    
    func next(positions: [Int]) -> [[Int]] {
        
        var result: [[Int]] = []
        
        let lastPosition = positions.last!
        
        if lastPosition == 100 {
            return [positions]
        }
        
        if lastPosition >= 94 {
            var copyPositions = positions
            copyPositions.append(100)
            return [copyPositions]
        }
        
        for i in 1...6 {
            var copyPositions = positions
            var newPosition = lastPosition + i
            
            if i < 6 && !ladders.keys.contains(newPosition) && !snakes.keys.contains(newPosition) {
                continue
            }
            
            if copyPositions.contains(newPosition) {
                continue
            } else {
                copyPositions.append(newPosition)
            }
            
            if snakes.keys.contains(newPosition) {
                newPosition = snakes[newPosition]!
                
                if copyPositions.contains(newPosition) {
                    continue
                } else {
                    copyPositions.append(newPosition)
                    
                    if newPosition == 100 {
                        return [copyPositions]
                    }
                }
            } else if ladders.keys.contains(newPosition) {
                newPosition = ladders[newPosition]!
                
                if copyPositions.contains(newPosition) {
                    continue
                } else {
                    copyPositions.append(newPosition)
                    
                    if newPosition == 100 {
                        return [copyPositions]
                    }
                }
            }
            
            result.append(contentsOf: next(positions: copyPositions))
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_229Tests: XCTestCase {

    func test_sal() {
        
        let game = SnakesAndLadders(snakes: [
        16: 6, 48: 26, 49: 11, 56: 53, 62: 19, 64: 60, 87: 24, 93: 73, 95: 75, 98: 78
        ], ladders: [1: 38, 4: 14, 9: 31, 21: 42, 28: 84, 36: 44, 51: 67, 71: 91, 80: 100])
        
        print(game.optimalPath())
    }

}
```