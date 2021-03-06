## Description

The Tower of Hanoi is a puzzle game with three rods and n disks, each a different size.

All the disks start off on the first rod in a stack. They are ordered by size, with the largest disk on the bottom and the smallest one at the top.

The goal of this puzzle is to move all the disks from the first rod to the last rod while following these rules:

You can only move one disk at a time.
A move consists of taking the uppermost disk from one of the stacks and placing it on top of another stack.
You cannot place a larger disk on top of a smaller disk.
Write a function that prints out all the steps necessary to complete the Tower of Hanoi. You should assume that the rods are numbered, with the first rod being 1, the second (auxiliary) rod being 2, and the last (goal) rod being 3.

For example, with n = 3, we can do this in 7 moves:

```
Move 1 to 3
Move 1 to 2
Move 3 to 2
Move 1 to 3
Move 2 to 1
Move 2 to 3
Move 1 to 3
```

## Solution

```swift
class HanoiGame {
    var rods: [HanoiRod]
    var disks: Int
    
    init(withDisks n: Int) {
        let rod1 = HanoiRod()
        let rod2 = HanoiRod()
        let rod3 = HanoiRod()
        
        for i in stride(from: n, to: 0, by: -1) {
            _ = try? rod1.push(node: HanoiDisk(value: i))
        }
        
        self.rods = [rod1, rod2, rod3]
        self.disks = n
    }
    
    func move(from: Int, to: Int) {
        if let disk = rods[from].pop() {
            if let disk = try? rods[to].push(node: disk) {
                print("move disk \(disk.value) from \(from) to \(to)")
            } else {
                print("moving from \(from) to \(to): push failed")
            }
        } else {
            print("moving from \(from) to \(to): pop failed")
        }
        
        log()
    }
    
    func solve() {
        solve(value: disks, from: 0, other: 1, to: 2)
    }
    
    private func solve(value: Int, from: Int, other: Int, to: Int) {
        if value == 1 {
            move(from: from, to: to)
            return
        }
        
        solve(value: value-1, from: from, other: to, to: other)
        move(from: from, to: to)
        solve(value: value-1, from: other, other: from, to: to)
    }
    
    func log() {
        print(rods[0].values())
        print(rods[1].values())
        print(rods[2].values())
    }
}

class HanoiDisk {
    var value: Int
    var next: HanoiDisk?
    
    init(value: Int, next: HanoiDisk?) {
        self.value = value
        self.next = next
    }
    
    init(value: Int) {
        self.value = value
        self.next = nil
    }
    
    func last() -> (node: HanoiDisk, parent: HanoiDisk?) {
        if let next = next {
            if let _ = next.next {
                return next.last()
            }
            
            return (node: next, parent: self)
        }
        
        return (node: self, parent: nil)
    }
    
    func popLast() -> (node: HanoiDisk?, newTail: HanoiDisk?)? {
        if let next = next {
            if let _ = next.next {
                return next.popLast()
            } else {
                let tmp = self.next
                self.next = nil
                return (tmp, self)
            }
        } else {
            return nil
        }
    }
    
    func values() -> String {
        let result = "\(value)"
        
        if let next = next {
            return "\(result)\(next.values())"
        }
        
        return result
    }
}

enum HanoiError: Error {
    case lowerDiskSmallerThanNewOne
}

class HanoiRod {
    var root: HanoiDisk?
    var tail: HanoiDisk?
    
    func push(node: HanoiDisk) throws -> HanoiDisk? {
        if let tail = tail {
            guard node.value <= tail.value else {
                throw HanoiError.lowerDiskSmallerThanNewOne
            }
            
            tail.next = node
            self.tail = node
            
            return self.tail
        }
        
        if let root = root {
            root.next = node
            self.tail = node
            
            return self.tail
        }
        
        self.root = node
        self.tail = node
        
        return self.tail
    }
    
    func pop() -> HanoiDisk? {
        if let root = root {
            if let last = root.popLast(), let node = last.node, let newTail = last.newTail {
                self.tail = newTail
                return node
            } else {
                let tmp = root
                
                self.root = nil
                self.tail = nil
                
                return tmp
            }
        }
        
        return nil
    }
    
    func values() -> String {
        if let root = root {
            return root.values()
        }
        
        return "_"
    }
}
```

## Test

```swift
class Problem_128Tests: XCTestCase {

    func test_disk_on_top_on_smaller_one() {
        var success = false
        
        let rod1 = HanoiRod()
        
        do {
            _ = try rod1.push(node: HanoiDisk(value: 1))
            _ = try rod1.push(node: HanoiDisk(value: 2))
        } catch {
            success = true
        }
        
        XCTAssert(success)
    }
    
    func test_hanoi_game() {
        let game = HanoiGame(withDisks: 3)
        
        game.move(from: 0, to: 1)
    }
    
    func test_solver() {
        let game = HanoiGame(withDisks: 4)
        game.solve()
    }

}
```