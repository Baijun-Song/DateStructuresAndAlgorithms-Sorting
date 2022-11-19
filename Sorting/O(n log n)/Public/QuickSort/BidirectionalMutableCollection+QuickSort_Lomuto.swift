extension MutableCollection where Self: BidirectionalCollection {
  public mutating func quickSort_Lomuto(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    __quickSort_Lomuto(
      by: areInAscendingOrder,
      lowerBound: startIndex,
      uppedBound: index(before: endIndex)
    )
  }
  
  public func quickSorted_Lomuto(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.quickSort_Lomuto(by: areInAscendingOrder)
    return copy
  }
  
  private mutating func __quickSort_Lomuto(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    uppedBound: Index
  ) {
    guard lowerBound < uppedBound else {
      return
    }
    let pivotIndex = __partition_Lomuto(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: uppedBound
    )
    __quickSort_Lomuto(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      uppedBound: index(before: pivotIndex)
    )
    __quickSort_Lomuto(
      by: areInAscendingOrder,
      lowerBound: index(after: pivotIndex),
      uppedBound: uppedBound
    )
  }
  
  private mutating func __partition_Lomuto(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) -> Index {
    let pivot = self[upperBound]
    var middleIndex = lowerBound
    var currentIndex = lowerBound
    while currentIndex < upperBound {
      if areInAscendingOrder(self[currentIndex], pivot) {
        swapAt(currentIndex, middleIndex)
        formIndex(after: &middleIndex)
      }
      formIndex(after: &currentIndex)
    }
    swapAt(middleIndex, upperBound)
    return middleIndex
  }
}
