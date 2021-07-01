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
            let firstLetter = char.isUppercase ? Character("A") : Character("a")
            let firstLetterAscii = firstLetter.asciiValue!
            let shiftedAscii = ((asciiValue + shift) - firstLetterAscii) % 26 + firstLetterAscii
            let encryptedChar = Character(UnicodeScalar(shiftedAscii))
            output.append(encryptedChar)
        }
        return output
    }
    
    func decrypt(_ input: String, shift: UInt8) -> String {
        var output = ""
        for char in input {
            guard char.isASCII, char.isLetter, let asciiValue = char.asciiValue else {
                output.append(char)
                continue
            }
            let firstLetter = char.isUppercase ? Character("A") : Character("a")
            let firstLetterAscii = firstLetter.asciiValue!
            let adjustment: UInt8 = (asciiValue - shift) < firstLetterAscii ? 26 : 0
            let shiftedAscii = ((asciiValue - shift) + adjustment - firstLetterAscii) % 26 + firstLetterAscii
            let encryptedChar = Character(UnicodeScalar(shiftedAscii))
            output.append(encryptedChar)
        }
        return output
    }
}

class CaesarCipherTests: XCTestCase {

    func makeSUT() -> CaesarCipher {
        return CaesarCipher()
    }
    
    // MARK: - Encryption
    
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
    
    func testEncrypt_overflow_success() {
        let sut = makeSUT()
        
        let actual = sut.encrypt("Z", shift: 1)
        XCTAssertEqual("A", actual)
    }
    
    func testEncrypt_specialChars_ignore() {
        let sut = makeSUT()
        
        let expected = " ~!@#$%^&*()_+`-=;:/?,.<>\\\"'"
        let actual = sut.encrypt(expected, shift: 5)
        XCTAssertEqual(expected, actual)
    }

    // MARK: - Decryption
    func testDecrypt_noShift_success() {
        let sut = makeSUT()
        
        let actual = sut.decrypt("a", shift: 0)
        XCTAssertEqual("a", actual)
    }
    
    func testDecrypt_lowercase_success() {
        let sut = makeSUT()

        let actual = sut.decrypt("b", shift: 1)
        XCTAssertEqual("a", actual)
    }

    func testDecrypt_uppercase_success() {
        let sut = makeSUT()

        let actual = sut.decrypt("B", shift: 1)
        XCTAssertEqual("A", actual)
    }

    func testDecrypt_overflow_success() {
        let sut = makeSUT()

        let actual = sut.decrypt("A", shift: 1)
        XCTAssertEqual("Z", actual)
    }

    func testDecrypt_specialChars_ignore() {
        let sut = makeSUT()

        let expected = " ~!@#$%^&*()_+`-=;:/?,.<>\\\"'"
        let actual = sut.decrypt(expected, shift: 5)
        XCTAssertEqual(expected, actual)
    }
    
}
