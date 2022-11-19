extension Array {
  public mutating func mergeSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let sorted = mergeSorted(by: areInAscendingOrder)
    self = sorted
  }
  
  public func mergeSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    guard count > 1 else {
      return self
    }
    let middleIndex = count / 2
    let leftSlice = self[..<middleIndex]
    let rightSlice = self[middleIndex...]
    
    let left = Array(leftSlice).mergeSorted(by: areInAscendingOrder)
    let right = Array(rightSlice).mergeSorted(by: areInAscendingOrder)
    return __merge(left, right, by: areInAscendingOrder)
  }
  
  private func __merge(
    _ left: Self,
    _ right: Self,
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var result: [Element] = []
    result.reserveCapacity(left.count + right.count)
    var leftIndex = 0
    var rightIndex = 0
    
    while leftIndex < left.count, rightIndex < right.count {
      let leftElement = left[leftIndex]
      let rightElement = right[rightIndex]
      if areInAscendingOrder(leftElement, rightElement) {
        result.append(leftElement)
        leftIndex += 1
      } else if areInAscendingOrder(rightElement, leftElement) {
        result.append(rightElement)
        rightIndex += 1
      } else {
        result.append(leftElement)
        result.append(rightElement)
        leftIndex += 1
        rightIndex += 1
      }
    }
    
    if leftIndex < left.count {
      result.append(contentsOf: left[leftIndex...])
    }
    if rightIndex < right.count {
      result.append(contentsOf: right[rightIndex...])
    }
    return result
  }
}
