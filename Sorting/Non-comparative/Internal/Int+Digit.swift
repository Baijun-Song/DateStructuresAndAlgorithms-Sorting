extension Int {
  var _digitCount: Int {
    var count = 0
    var copy = self
    while copy != 0 {
      count += 1
      copy /= 10
    }
    return count
  }
  
  func _digitFromRight(at position: Int) -> Int? {
    precondition(position >= 0)
    let remain = self / Int(pow(10.0, Double(position)))
    return remain == 0 ? nil : (remain % 10)
  }
  
  func _digitFromLeft(at position: Int) -> Int? {
    _digitFromRight(at: _digitCount - 1 - position)
  }
}

