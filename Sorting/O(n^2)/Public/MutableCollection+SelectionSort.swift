extension MutableCollection {
  public mutating func selectionSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    for lowerIndex in indices {
      var candidate = lowerIndex
      var currentIndex = index(after: lowerIndex)
      while currentIndex < endIndex {
        if areInAscendingOrder(self[currentIndex], self[candidate]) {
          candidate = currentIndex
        }
        formIndex(after: &currentIndex)
      }
      if candidate != lowerIndex {
        swapAt(candidate, lowerIndex)
      }
    }
  }
  
  public func selectionSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.selectionSort(by: areInAscendingOrder)
    return copy
  }
}
