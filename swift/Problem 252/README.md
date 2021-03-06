## Description

This problem was asked by Palantir.

The ancient Egyptians used to express fractions as a sum of several terms where each numerator is one. For example, 4 / 13 can be represented as 1 / 4 + 1 / 18 + 1 / 468.

Create an algorithm to turn an ordinary fraction a / b, where a < b, into an Egyptian fraction.

## Solution

```swift
typealias Fraction = (numerator: Int, denominator: Int)

struct EgyptianMaths {
    
    func convertFraction(fraction: Fraction) -> [Fraction] {
        
        if fraction.numerator == 1 {
            return [fraction]
        }
        
        var result: [Fraction] = []
        
        let newDenominator = Int(ceil(Double(fraction.denominator) / Double(fraction.numerator)))
        result.append((1, newDenominator))
        
        let newFractionNumerator = fraction.numerator * newDenominator - fraction.denominator
        let newFractionDenominator = newDenominator * fraction.denominator
        
        let gcd = greatestCommonDivisor(left: newFractionNumerator, right: newFractionDenominator)
        
        let newFraction: Fraction = (newFractionNumerator / gcd, newFractionDenominator / gcd)
        result.append(contentsOf: convertFraction(fraction: newFraction))
        
        return result
    }
    
    func reduceFraction(fraction: Fraction) -> Fraction {
        
        
        
        return fraction
    }
    
    func greatestCommonDivisor(left: Int, right: Int) -> Int {
        
        if left == 1 || right == 1 {
            return 1
        }
        
        if left == right {
            
            return left
        } else {
            if left > right {
                
                return greatestCommonDivisor(left: left-right, right: right)
            } else {
                
                return greatestCommonDivisor(left: left, right: right-left)
            }
        }
    }
}
```

## Tests

```swift
class Problem_252Tests: XCTestCase {

    func test_example() {
        
        let em = EgyptianMaths()
        let actual = em.convertFraction(fraction: (4, 13))
        
        XCTAssert(actual.count == 3)
        XCTAssert(actual[0] == (1, 4))
        XCTAssert(actual[1] == (1, 18))
        XCTAssert(actual[2] == (1, 468))
    }

}
```