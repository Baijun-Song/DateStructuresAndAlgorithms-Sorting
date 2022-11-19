extension MutableCollection where Self: BidirectionalCollection {
  public mutating func quickSort_Hoare(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    __quickSort_Hoare(
      by: areInAscendingOrder,
      lowerBound: startIndex,
      upperBound: index(before: endIndex)
    )
  }
  
  public func quickSorted_Hoare(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.quickSort_Hoare(by: areInAscendingOrder)
    return copy
  }
  
  private mutating func __quickSort_Hoare(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) {
    guard lowerBound < upperBound else {
      return
    }
    let pivotIndex = __partition_Hoare(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: upperBound
    )
    __quickSort_Hoare(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: pivotIndex
    )
    __quickSort_Hoare(
      by: areInAscendingOrder,
      lowerBound: index(after: pivotIndex),
      upperBound: upperBound
    )
  }
  
  private mutating func __partition_Hoare(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) -> Index {
    let pivotIndex = __medianIndexOfThree(
      by: areInAscendingOrder,
      lowerBound: lowerBound,
      upperBound: upperBound
    )
    let pivot = self[pivotIndex]
    var lowerIndex = index(before: lowerBound)
    var upperIndex = index(after: upperBound)
    while true {
      repeat {
        formIndex(after: &lowerIndex)
      } while areInAscendingOrder(self[lowerIndex], pivot)
      
      repeat {
        formIndex(before: &upperIndex)
      } while areInAscendingOrder(pivot, self[upperIndex])
      
      if lowerIndex < upperIndex {
        swapAt(lowerIndex, upperIndex)
      } else {
        return upperIndex
      }
    }
  }
  
  private func __medianIndexOfThree(
    by areInAscendingOrder: (Element, Element) -> Bool,
    lowerBound: Index,
    upperBound: Index
  ) -> Index {
    let distance = distance(from: lowerBound, to: upperBound)
    var middleIndex = index(lowerBound, offsetBy: distance / 2)
    let middleElement = self[middleIndex]
    if areInAscendingOrder(middleElement, self[lowerBound]) {
      middleIndex = lowerBound
    }
    if areInAscendingOrder(self[upperBound], middleElement) {
      middleIndex = upperBound
    }
    return middleIndex
  }
}

