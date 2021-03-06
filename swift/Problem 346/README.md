## Description

This problem was asked by Airbnb.

You are given a huge list of airline ticket prices between different cities around the world on a given day. These are all direct flights. Each element in the list has the format `(source_city, destination, price)`.

Consider a user who is willing to take up to `k` connections from their origin city `A` to their destination `B`. Find the cheapest fare possible for this journey and print the itinerary for that journey.

For example, our traveler wants to go from `JFK` to `LAX` with up to 3 connections, and our input flights are as follows:

```
[
    ('JFK', 'ATL', 150),
    ('ATL', 'SFO', 400),
    ('ORD', 'LAX', 200),
    ('LAX', 'DFW', 80),
    ('JFK', 'HKG', 800),
    ('ATL', 'ORD', 90),
    ('JFK', 'LAX', 500),
]
```

Due to some improbably low flight prices, the cheapest itinerary would be `JFK -> ATL -> ORD -> LAX`, costing `$440`.

## Solution

```swift
typealias Flight = (from: String, to: String, price: Int)

struct AirbnbFlights {
    
    let flights: [Flight]
    
    func cheapestTrip(from: String, to: String, withMaxConnection: Int) -> Int {
        
        
        let candidates = find(current: [], from: from, to: to, remainingConnections: withMaxConnection, visited: [])
        
        let mapped = candidates.map({ $0.reduce(0) { $0 + $1.price } })
        let sorted = mapped.sorted{ $0 < $1 }
        
        return sorted.first ?? 0
    }
    
    private func find(current: [Flight], from: String, to: String, remainingConnections: Int, visited: [String]) -> [[Flight]] {
        
        if remainingConnections == 0 {
            return [current]
        }
        
        var candidates: [[Flight]] = []
        
        if current.isEmpty {
            for flight in flights {
                if flight.from == from && flight.to == to {
                    candidates.append([flight])
                } else if flight.from == from {
                    candidates.append(contentsOf: find(current: [flight], from: from, to: to, remainingConnections: remainingConnections-1, visited: [flight.to]))
                }
            }
            
            return candidates
        }
        
        let lastLocation = current.last!.to
        
        for flight in flights {
            if visited.contains(flight.to) { continue }
            
            if flight.from == lastLocation && flight.to == to {
                var trip = current
                trip.append(flight)
                candidates.append(trip)
            } else if flight.from == lastLocation {
                var newCurrent = current
                newCurrent.append(flight)
                var newVisited = visited
                newVisited.append(flight.to)
                candidates.append(contentsOf: find(current: newCurrent, from: from, to: to, remainingConnections: remainingConnections-1, visited: newVisited))
            }
        }
        
        return candidates
    }
}
```

## Tests

```swift
class Problem_346Tests: XCTestCase {

    func test_example() {
        
        let input = AirbnbFlights(flights: [
            Flight(from: "JFK", to: "ATL", 150),
            Flight(from: "ATL", to: "SFO", 400),
            Flight(from: "ORD", to: "LAX", 200),
            Flight(from: "LAX", to: "DFW", 80),
            Flight(from: "JFK", to: "HKG", 800),
            Flight(from: "ATL", to: "ORD", 90),
            Flight(from: "JFK", to: "LAX", 500),
        ])
        
        let actual = input.cheapestTrip(from: "JFK", to: "LAX", withMaxConnection: 3)
        let expected = 440
        
        XCTAssert(actual == expected)
    }

}
```