import List

extension LinkedList {
  public mutating func mergeSort(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) {
    let unsafeNodes = breakIntoUnsafeNodes()
    let sortedUnsafeNodes = __mergeSort(
      unsafeNodes,
      by: areInAscendingOrder
    )
    self = LinkedList(unsafeNodes: sortedUnsafeNodes)
  }
  
  private func __mergeSort(
    _ unsafeNodes: [LinkedList.UnsafeNode],
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> [LinkedList.UnsafeNode] {
    unsafeNodes.mergeSorted { a, b in
      areInAscendingOrder(a.value, b.value)
    }
  }

  public func mergeSorted(
    by areInAscendingOrder: (Element, Element) -> Bool
  ) -> Self {
    var copy = self
    copy.mergeSort(by: areInAscendingOrder)
    return copy
  }
}
