## Description

This problem was asked by Quora.

Word sense disambiguation is the problem of determining which sense a word takes on in a particular setting, if that word has multiple meanings. For example, in the sentence "I went to get money from the bank", bank probably means the place where people deposit money, not the land beside a river or lake.

Suppose you are given a list of meanings for several words, formatted like so:

```
{
    "word_1": ["meaning one", "meaning two", ...],
    ...
    "word_n": ["meaning one", "meaning two", ...]
}
```

Given a sentence, most of whose words are contained in the meaning list above, create an algorithm that determines the likely sense of each possibly ambiguous word.

## Solution

```swift
struct QuoraChallenge {
    
    var meanings: [String: [String]]
    
    func meaning(of word: String, in sentence: String) -> [String] {
        
        guard meanings.keys.contains(word) else {
            fatalError("can't find \(word) in the bank")
        }
        
        // TODO: - This should be improve by removing common words such as "the", "a", etc.
        let allWords = sentence.split(separator: " ")
        let allMeanings = meanings[word]!
        
        var candidates: [String: Int] = [:]
        
        for aMeaning in allMeanings {
            
            if !candidates.keys.contains(aMeaning) {
                candidates[aMeaning] = 0
            }
        }
        
        for pair in candidates {
            
            for word in allWords {
                if pair.key.contains(word) {
                    candidates[pair.key] = candidates[pair.key]! + 1
                }
            }
        }
        
        var maxRef = 0
        
        for pair in candidates {
            if pair.value > maxRef {
                maxRef = pair.value
            }
        }
        
        var result: [String] = []
        
        for pair in candidates {
            if pair.value == maxRef {
                result.append(pair.key)
            }
        }
        
        return result
        
    }
}
```

## Tests

```swift
class Problem_351Tests: XCTestCase {

    func test_quora_meaning() {
        
        let input = QuoraChallenge(meanings: [
            "bank" : [
                "a place where people deposit money",
                "a land beside a river or lake"
            ]
        ])
        
        let actual = input.meaning(of: "bank", in: "I went to get money from the bank")
        let expected = ["a place where people deposit money"]
        
        XCTAssert(actual == expected)
    }

}
```