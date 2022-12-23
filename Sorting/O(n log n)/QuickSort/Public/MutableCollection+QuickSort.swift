extension MutableCollection {
  public mutating func quickSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    quickSort(in: startIndex..<endIndex, by: areInAscendingOrder)
  }
  
  public func quickSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.quickSort(by: areInAscendingOrder)
    return copy
  }
  
  private mutating func quickSort(
    in subrange: Range<Index>,
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let lowerBound = subrange.lowerBound
    let upperBound = subrange.upperBound
    let distance = distance(from: lowerBound, to: upperBound)
    guard distance > 1 else {
      return
    }
    let pivotIndex = index(lowerBound, offsetBy: distance / 2)
    let pivot = self[pivotIndex]
    
    let partitionIndex = partition(
      from: pivot,
      in: subrange,
      by: areInAscendingOrder
    )
    quickSort(in: lowerBound..<partitionIndex, by: areInAscendingOrder)
    quickSort(in: partitionIndex..<upperBound, by: areInAscendingOrder)
  }
  
  private mutating func partition(
    from pivot: Element,
    in subrange: Range<Index>,
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Index {
    var middleIndex = subrange.lowerBound
    var currentIndex = subrange.lowerBound
    while currentIndex < subrange.upperBound {
      if areInAscendingOrder(self[currentIndex], pivot) {
        swapAt(currentIndex, middleIndex)
        formIndex(after: &middleIndex)
      }
      formIndex(after: &currentIndex)
    }
    return middleIndex
  }
}
