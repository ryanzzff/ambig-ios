//
//  CaesarCipherTests.swift
//  ambig-frameworkTests
//
//  Created by Ryan Lee on 1/7/2021.
//

import XCTest

struct CaesarCipher {
    
    func encrypt(_ input: String, shift: Int) -> String {
        return input.map { char in
            guard char.isASCII, char.isLetter else {
                return String(char)
            }
            
            return String(char.shift(shift))
        }.joined()
    }
    
    func decrypt(_ input: String, shift: Int) -> String {
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

class CaesarCipherTests: XCTestCase {

    func makeSUT() -> CaesarCipher {
        return CaesarCipher()
    }
    
    // MARK: - Encryption
    
    func testEncrypt_shiftCycle_noShift() {
        let sut = makeSUT()

        let expected = "aAzZ"
        var actual = sut.encrypt(expected, shift: -52)
        XCTAssertEqual(expected, actual)
        
        actual = sut.encrypt(expected, shift: -26)
        XCTAssertEqual(expected, actual)
        
        actual = sut.encrypt(expected, shift: 0)
        XCTAssertEqual(expected, actual)
        
        actual = sut.encrypt(expected, shift: 26)
        XCTAssertEqual(expected, actual)
        
        actual = sut.encrypt(expected, shift: 52)
        XCTAssertEqual(expected, actual)
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
    
    func testEncrypt_lowerCaseOverflow_success() {
        let sut = makeSUT()
        
        let actual = sut.encrypt("z", shift: 1)
        XCTAssertEqual("a", actual)
    }
    
    func testEncrypt_upperCaseOverflow_success() {
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
    func testDecrypt_shiftCycle_noShift() {
        let sut = makeSUT()

        let expected = "aAzZ"
        var actual = sut.decrypt(expected, shift: -52)
        XCTAssertEqual(expected, actual)
        
        actual = sut.decrypt(expected, shift: -26)
        XCTAssertEqual(expected, actual)
        
        actual = sut.decrypt(expected, shift: 0)
        XCTAssertEqual(expected, actual)
        
        actual = sut.decrypt(expected, shift: 26)
        XCTAssertEqual(expected, actual)
        
        actual = sut.decrypt(expected, shift: 52)
        XCTAssertEqual(expected, actual)
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
    
    func testDecrypt_lowerCaseOverflow_success() {
        let sut = makeSUT()

        let actual = sut.decrypt("a", shift: 1)
        XCTAssertEqual("z", actual)
    }

    func testDecrypt_upperCaseOverflow_success() {
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
