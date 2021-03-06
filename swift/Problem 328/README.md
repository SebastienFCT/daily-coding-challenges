## Description

This problem was asked by Facebook.

In chess, the Elo rating system is used to calculate player strengths based on game results.

A simplified description of the Elo system is as follows. Every player begins at the same score. For each subsequent game, the loser transfers some points to the winner, where the amount of points transferred depends on how unlikely the win is. For example, a 1200-ranked player should gain much more points for beating a 2000-ranked player than for beating a 1300-ranked player.

Implement this system.

## Solution

```swift
typealias PlayerElo = (player: String, elo: Int)
struct Elo {

    var players: [PlayerElo]
    var minRank: Int
    
    mutating func addPlayer(username: String) -> PlayerElo? {
        
        if players.contains(where: { (playerElo) -> Bool in
            playerElo.player == username
        }) {
            print("username already taken")
            return nil
        }
        
        let newPlayerElo = (username, minRank)
        players.append(newPlayerElo)
        
        return newPlayerElo
    }
    
    mutating func simulateWin(fromUserAtIndex winnerIndex: Int, againstUserAtIndex looserIndex: Int) {
        
        guard winnerIndex < players.count && looserIndex < players.count else {
            fatalError("index out of bounds")
        }
        
        var difference = abs(players[winnerIndex].elo - players[looserIndex].elo)
        
        if players[winnerIndex].elo > players[looserIndex].elo {
            // winner was higher rank
            difference = minRank/10 - difference
            difference = max(difference, minRank/10)
        } else if players[winnerIndex].elo < players[looserIndex].elo {
            // winner was lower rank
            difference = minRank/10 + difference
        } else {
            // same score
            difference = minRank/10
        }
        
        players[winnerIndex].elo += difference
        players[looserIndex].elo -= difference
        
        print("\(players[winnerIndex].player) beats \(players[looserIndex].player)")
        
        players[looserIndex].elo = players[looserIndex].elo < minRank ? minRank : players[looserIndex].elo
    }
    
    func score() -> String {
        
        var score = ""
        
        for player in players {
            score += "\(player.player): \(player.elo) \n"
        }
        
        score += "===="
        
        return score
    }
    
}
```

## Tests

```swift
class Problem_328Tests: XCTestCase {

    func test_elo() {
        
        var elo = Elo(players: [], minRank: 100)
        
        _ = elo.addPlayer(username: "sebastien")
        _ = elo.addPlayer(username: "john_doe")
        _ = elo.addPlayer(username: "jane_doe")
        _ = elo.addPlayer(username: "johny_doe")
        
        for _ in 0...100 {
            let rand1 = Int.random(in: 0...3)
            let rand2 = Int.random(in: 0...3)
            
            if rand1 != rand2 {
                elo.simulateWin(fromUserAtIndex: rand1, againstUserAtIndex: rand2)
                print(elo.score())
            }
        }
    }

}
```