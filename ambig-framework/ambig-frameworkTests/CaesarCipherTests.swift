//
//  CaesarCipherTests.swift
//  ambig-frameworkTests
//
//  Created by Ryan Lee on 1/7/2021.
//

import XCTest

struct CaesarCipher {
    
    func encrypt(_ input: String, shift: UInt8) -> String {
        var output = ""
        for char in input {
            guard char.isASCII, char.isLetter, let asciiValue = char.asciiValue else {
                output.append(char)
                continue
            }
            
            let encryptedChar = Character(UnicodeScalar(asciiValue + shift))
            output.append(encryptedChar)
        }
        return output
    }
}

class CaesarCipherTests: XCTestCase {

    func makeSUT() -> CaesarCipher {
        return CaesarCipher()
    }
    
    func testEncrypt_noShift_success() {
        let sut = makeSUT()
        
        let actual = sut.encrypt("a", shift: 0)
        XCTAssertEqual("a", actual)
    }
    
    func testEncrypt_lowercase_success() {
        let sut = makeSUT()
        
        let actual = sut.encrypt("a", shift: 1)
        XCTAssertEqual("b", actual)
    }
    
    func testEncrypt_uppercase_success() {
        let sut = makeSUT()
        
        let actual = sut.encrypt("A", shift: 1)
        XCTAssertEqual("B", actual)
    }
    
    func testEncrypt_specialChars_ignore() {
        let sut = makeSUT()
        
        let expected = " ~!@#$%^&*()_+`-=;:/?,.<>\\\"'"
        let actual = sut.encrypt(expected, shift: 5)
        XCTAssertEqual(expected, actual)
    }

}
