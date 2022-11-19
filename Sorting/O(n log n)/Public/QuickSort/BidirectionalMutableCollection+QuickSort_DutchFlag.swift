extension MutableCollection where Self: BidirectionalCollection {
  public mutating func quickSort_DutchFlag(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    __quickSort_DutchFlag(
      by: areInAscendingOrder,
      lowerBound: startIndex,
      upperBound: index(before: endIndex)
    )
  }
  
  public func quickSorted_DutchFlag(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.quickSort_DutchFlag(by: areInAscendingOrder)
    return copy
  }
  
  private mutating func __quickSort_DutchFlag(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) {
    guard lowerBound < upperBound else {
      return
    }
    let (lowerPivotIndex, upperPivotIndex) = __partition_DutchFlag(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: upperBound
    )
    __quickSort_DutchFlag(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: index(before: lowerPivotIndex)
    )
    __quickSort_DutchFlag(
      by: areInAscendingOrder,
      lowerBound: index(after: upperPivotIndex),
      upperBound: upperBound
    )
  }
  
  private mutating func __partition_DutchFlag(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) -> (lowerIndex: Index, upperIndex: Index) {
    let pivot = self[upperBound]
    var lowerIndex = lowerBound
    var middleIndex = lowerBound
    var upperIndex = upperBound
    while middleIndex <= upperIndex {
      let middleElement = self[middleIndex]
      if areInAscendingOrder(middleElement, pivot) {
        swapAt(lowerIndex, middleIndex)
        formIndex(after: &lowerIndex)
        formIndex(before: &middleIndex)
      } else if areInAscendingOrder(pivot, middleElement) {
        swapAt(middleIndex, upperIndex)
        formIndex(before: &upperIndex)
      } else {
        formIndex(after: &middleIndex)
      }
    }
    return (lowerIndex, upperIndex)
  }
}
