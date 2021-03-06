## Description

This problem was asked by Jane Street.

The United States uses the imperial system of weights and measures, which means that there are many different, seemingly arbitrary units to measure distance. There are 12 inches in a foot, 3 feet in a yard, 22 yards in a chain, and so on.

Create a data structure that can efficiently convert a certain quantity of one unit to the correct amount of any other unit. You should also allow for additional units to be added to the system.

## Solution

```swift
struct FCTUnit: Hashable {
    var label: String = ""
    var multiplier: Float = 0
    
    static func == (lhs: FCTUnit, rhs: FCTUnit) -> Bool {
        return lhs.label == rhs.label
    }
}

struct CustomSystem {
    
    var units: [FCTUnit]
    
    mutating func inserUnitWithLabel(_ label: String, reference: String, withMutiplier: Float) {
        
        guard units.contains(where: { (a_unit) -> Bool in
            a_unit.label == reference
        }) else {
            fatalError("reference \(reference) unit not found in the system.")
        }
        
        var ref: FCTUnit!
        
        for unit in units {
            if unit.label == reference {
                ref = unit
            }
        }
        
        if units.contains(where: { (a_unit) -> Bool in
            a_unit.label == label
        }) {
            units.removeAll { (a_unit) -> Bool in
                a_unit.label == label
            }
        }
        
        let newUnit = FCTUnit(label: label, multiplier: ref.multiplier * withMutiplier)
        units.append(newUnit)
    }
    
    func convert(fromUnit: String, toUnit: String, value: Float) -> Float {
        
        if !units.contains(where: { (a_unit) -> Bool in
            a_unit.label == fromUnit
        }) {
            fatalError("Unit \(fromUnit) not found")
        }
        
        if !units.contains(where: { (a_unit) -> Bool in
            a_unit.label == toUnit
        }) {
            fatalError("Unit \(fromUnit) not found")
        }
        
        let from = units.filter{ $0.label == fromUnit }.first!
        let to = units.filter{ $0.label == toUnit }.first!
        
        return value / to.multiplier * from.multiplier
    }
}
```

## Tests

```swift
class Problem_325Tests: XCTestCase {

    func test_converter() {
        
        var system = CustomSystem(units: [FCTUnit(label: "inches", multiplier: 1)])
        
        system.inserUnitWithLabel("foot", reference: "inches", withMutiplier: 12)
        system.inserUnitWithLabel("yard", reference: "foot", withMutiplier: 3)
        system.inserUnitWithLabel("chain", reference: "yard", withMutiplier: 22)
        
        let actual = system.convert(fromUnit: "chain", toUnit: "foot", value: 1)
        let expected: Float = 66
        
        XCTAssert(actual == expected)
    }

}
```