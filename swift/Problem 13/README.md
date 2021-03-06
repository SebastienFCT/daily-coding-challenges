### Description

This problem was asked by Amazon.

Given an integer `k` and a string `s`, find the length of the longest substring that contains at most `k` distinct characters.

For example, given `s = "abcba"` and `k = 2`, the longest substring with `k` distinct characters is `"bcb"`.

### Solution

```swift
extension String {
    func findLargestSubstringWithMaximumDistinctCharacter(_ distinctCharacters: Int) -> String {
        var result = ""
        
        for i in 0...(self.count - 1) {
            let evaluation = String(self.suffix(self.count - i)).substringWith(distinctCharacters)
            
            if evaluation.count > result.count {
                result = evaluation
            }
        }
        
        return result
    }
    
    func substringWith(_ maximumDistinctCharacters: Int) -> String {
        var reference: Set<Character> = Set()
        var result: String = ""
        
        for char in self {
            reference.insert(char)
            
            if reference.count > maximumDistinctCharacters {
                return result
            }
            
            result += String(char)
        }
        
        return result
    }
}
```