//
//  CaesarCipher.swift
//  ambig-framework
//
//  Created by Ryan Lee on 1/7/2021.
//

import Foundation

public struct CaesarCipher {
    
    public init() {}
    
    public func encrypt(_ input: String, shift: Int) -> String {
        return input.map { char in
            guard char.isASCII, char.isLetter else {
                return String(char)
            }
            
            return String(char.shift(shift))
        }.joined()
    }
    
    public func decrypt(_ input: String, shift: Int) -> String {
        return encrypt(input, shift: shift * -1)
    }
    
}

private extension Character {
    
    func shift(_ shift: Int) -> Character {
        let lowerRange = self.isUppercase ? 65 : 97
        let upperRange = self.isUppercase ? 90 : 122
        
        guard let ascii = self.asciiValue else { return self }
        let shifted = Int(ascii) + shift
        if let scalar = UnicodeScalar(normalize(value: shifted, range: lowerRange...upperRange)) {
            return Character(scalar)
        }
        
        return self
    }
    
    private func normalize(value: Int, range: ClosedRange<Int>) -> Int {
        if value < range.lowerBound {
            let adjustment = (((range.lowerBound - value - 1) / 26) + 1) * 26
            return value + adjustment
        } else if value > range.upperBound {
            let adjustment = (((value - range.upperBound - 1) / 26) + 1) * 26
            return value - adjustment
        }
        return value
    }
}
