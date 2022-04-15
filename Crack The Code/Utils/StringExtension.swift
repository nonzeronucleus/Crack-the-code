import Foundation

public extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

public extension String {
  subscript(value: NSRange) -> Substring {
    self[value.lowerBound..<value.upperBound]
  }
}

public extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    self[index(at: value.lowerBound)...index(at: value.upperBound)]
  }

  subscript(value: CountableRange<Int>) -> Substring {
    self[index(at: value.lowerBound)..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    self[..<index(at: value.upperBound)]
  }

  subscript(value: PartialRangeThrough<Int>) -> Substring {
    self[...index(at: value.upperBound)]
  }

  subscript(value: PartialRangeFrom<Int>) -> Substring {
    self[index(at: value.lowerBound)...]
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

public extension String {
    // Returns the index of each character that matches exactly with the other string
    // and a list of letters that are in the other string but wrong position
    func overlap(with other:String) -> (exact:[Int], inWord:[Int]) {
        var exact:[Int] = []
        var inWord:[Int] = []
        var selfLetters:[Character?] = Array(self)
        var otherLetters:[Character?] = Array(other)
        
        for idx in 0...selfLetters.count-1 {
            if(selfLetters[idx] == otherLetters[idx]) {
                selfLetters[idx] = nil
                otherLetters[idx] = nil
                exact.append(idx)
            }
        }
        
        for idx in 0...self.count-1 {
            if let letterToFind = selfLetters[idx]{
                if let loc = otherLetters.firstIndex(of: letterToFind) {
                    inWord.append(idx)
                    selfLetters[idx] = nil
                    otherLetters[loc] = nil
                }
            }
        }

        return (exact, inWord)
    }
}
