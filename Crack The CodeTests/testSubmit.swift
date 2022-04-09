import XCTest
@testable import Crack_The_Code


class testSubmit: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Check that when some letters have been makred as possibly in the word, that they are then marked as not in the word if a completely wrong word is attempted
    func testWrongAttemptedLettersWithExistingLetters() throws {
        let origAttempts:Dictionary<String,LetterStatus> = ["T":.POSSIBLE,"S":.POSSIBLE,"E":.POSSIBLE,"V":.POSSIBLE]
        let targetAttempts:Dictionary<String,LetterStatus> = ["T":.POSSIBLE,"S":.POSSIBLE,"E":.NOT_IN_WORD,"V":.NOT_IN_WORD, "R":.NOT_IN_WORD,"A":.NOT_IN_WORD]

        let attemptedLetters = markAttemptedLetters(attemptedLetters: AttemptedLetters(attempts:origAttempts), currentGuess: "RAVER", wordToGuess: "TITCH")

        XCTAssertEqual(attemptedLetters,AttemptedLetters(attempts:targetAttempts))
    }
    
    // Check that if the guessLengths array is empty, that it successfully creates one at the right length
    func testGetGuessLengthsWithEmptyArray() throws {
        let maxGuesses = 12
        let lengths = getGuessLengths(guessedLengths: nil, maxGuesses: maxGuesses)
        
        XCTAssertEqual(lengths.count,maxGuesses)
    }
    
    // Check that if the guessLengths array already exists but is too short, then it's correctly extended
    func testGetGuessLengthsWithShortArray() throws {
        let oldMaxGuesses = 10
        let newMaxGuesses = 12
        var initLengths = [Int](repeating: 0, count: oldMaxGuesses)
        
        initLengths[4] = 7
        
        let lengths = getGuessLengths(guessedLengths: initLengths, maxGuesses: newMaxGuesses)
        
        XCTAssertEqual(lengths.count,newMaxGuesses)
        XCTAssertEqual(lengths[4],7)
        XCTAssertEqual(lengths[newMaxGuesses-1],0)
    }
}
