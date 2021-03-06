//
//  Solution.swift
//  Problem 17
//
//  Created by sebastien FOCK CHOW THO on 2019-06-16.
//  Copyright © 2019 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

struct FileSystem {
    var root: Item? = nil
    
    init() {
        self.root = nil
    }
    
    mutating func buildFileSystemFromString(_ string: String) {
        var rootVal = ""
        var string = string
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\t", with: "\\t")
        
        print(string)
        
        if string.isEmpty {
            root = Item(parent: nil, name: "", level: 1)
            return
        }
        
        while string.first! != "\\" {
            rootVal += String(string.first!)
            string = String(string.dropFirst())
            
            if string.isEmpty {
                root = Item(parent: nil, name: rootVal, level: 1)
                return
            }
        }
        
        root = Item(parent: nil, name: rootVal, level: 1)
        root!.buildChildren(withString: string)
    }
    
    func longestPath() -> String {
        
        if let root = root {
            return root.longestPath(true)
        }
        
        return ""
    }
}

class Item {
    var parent: Item? = nil
    var name: String
    var level: Int
    var children: [Item] = []
    
    init(parent: Item?, name: String, level: Int) {
        self.parent = parent
        self.name = name
        self.level = level
    }
    
    func buildChildren(withString string: String) {
        var string = string
        var previous = self
        
        if string.isEmpty {
            return
        }
        
        while !string.isEmpty {
            if String(string.prefix(2 + 2 * previous.level)) != "\\n\(String(repeating: "\\t", count: previous.level))" {
                
                if let parent = previous.parent {
                    previous = parent
                    continue
                } else {
                    fatalError("could not identify parent")
                }
            } else {
                string = String(string.dropFirst(2 + 2 * previous.level))
                
                var rest = string.split(separator: "\\", maxSplits: 1, omittingEmptySubsequences: true)
                
                let item = Item(parent: previous, name: String(rest[0]), level: previous.level + 1)
                previous.children.append(item)
                previous = item
                
                string = String(string.dropFirst(rest[0].count))
            }
        }
    }
    
    func longestPath(_ isRoot: Bool) -> String {
        if !children.isEmpty {
            var possibilities: [String] = []
            for child in children {
                possibilities.append("\((isRoot ? "" : "/"))\(name)\(child.longestPath(false))")
            }
            
            possibilities.sort{ $0.count > $1.count }
            return possibilities.first!
        }
        
        return "\((isRoot ? "" : "/"))\(name)"
    }
}
