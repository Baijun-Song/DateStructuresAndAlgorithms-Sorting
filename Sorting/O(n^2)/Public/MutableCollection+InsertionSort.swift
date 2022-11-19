extension MutableCollection {
  public mutating func insertionSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let reversedIndices = indices.reversed()
    guard let upperIndex = reversedIndices.first else {
      return
    }
    for lowerIndex in reversedIndices[1...] {
      var currentIndex = lowerIndex
      while currentIndex < upperIndex {
        let nextIndex = index(after: currentIndex)
        if areInAscendingOrder(self[nextIndex], self[currentIndex]) {
          swapAt(nextIndex, currentIndex)
        } else {
          break
        }
        currentIndex = nextIndex
      }
    }
  }
  
  public func insertionSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.insertionSort(by: areInAscendingOrder)
    return copy
  }
}
