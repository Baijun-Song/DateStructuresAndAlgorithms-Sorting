extension Array where Element == Int {
  public mutating func lexicographicalSort() {
    let sorted = lexicographicalSorted()
    self = sorted
  }
  
  public func lexicographicalSorted() -> Self {
    let positive = filter { $0 >= 0 }
    return __lexicographicalSort(
      positive, at: 0,
      maxDigitCount: (positive.max()?._digitCount ?? 0)
    )
  }
  
  private func __lexicographicalSort(
    _ elements: Self,
    at position: Int,
    maxDigitCount: Int
  ) -> Self {
    guard position < maxDigitCount else {
      return elements
    }
    var buckets: [[Int]] = .init(repeating: [], count: 10)
    var result: [Int] = []
    result.reserveCapacity(elements.count)
    
    for number in elements {
      if let digit = number._digitFromLeft(at: position) {
        buckets[digit].append(number)
      } else {
        result.append(number)
      }
    }
    for bucket in buckets {
      if !bucket.isEmpty {
        result.append(contentsOf: __lexicographicalSort(
          bucket,
          at: position + 1,
          maxDigitCount: maxDigitCount
        ))
      }
    }
    return result
  }
}
