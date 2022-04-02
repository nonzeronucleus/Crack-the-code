//
//  TestCorrectLetterCount.swift
//  Crack The CodeTests
//
//  Created by Ian Plumb on 02/04/2022.
//

import XCTest
@testable import Crack_The_Code

class TestCorrectLetterCount: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCompletelyWrong() throws {
        let count = calcCorrectLetters(wordToGuess:"AAAAA", guess:"BBBBB")

        XCTAssertEqual(count.correctPos,0)
        XCTAssertEqual(count.wrongPos,0)
    }
    
    func testCompletelyRight() throws {
        let count = calcCorrectLetters(wordToGuess:"AAAAA", guess:"AAAAA")
        
        XCTAssertEqual(count.correctPos,5)
        XCTAssertEqual(count.wrongPos,0)
    }
    
    func testDuplicateLetters() throws {
        let count = calcCorrectLetters(wordToGuess:"ABCDE", guess:"AABAA")

        XCTAssertEqual(count.correctPos,1)
        XCTAssertEqual(count.wrongPos,1)
    }

    func testDuplicateLetters2() throws {
        let count = calcCorrectLetters(wordToGuess:"AABAA", guess:"ABCDE")

        XCTAssertEqual(count.correctPos,1)
        XCTAssertEqual(count.wrongPos,1)
    }


//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
